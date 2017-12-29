//
//  WeatherHistoryViewController.swift
//  Weather History
//
//  Created by Mohamed Hamed on 12/28/17.
//  Copyright © 2017 Hamed. All rights reserved.
//
import Foundation
import UIKit
import CoreLocation
import NVActivityIndicatorView

class WeatherHistoryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: WeatherHistoryPresenter!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavbar()
        setupLocationManager()
        presenter = WeatherHistoryPresenter(viewController: self, collectionView: collectionView)
        presenter.requestWeatherData(onSuccess: nil, onFailure: nil)
        presenter.loadImages()
        if( traitCollection.forceTouchCapability == .available){
            registerForPreviewing(with: self, sourceView: view)
        }
    }
   

    func initNavbar() {
        title = "Weather Photos"
        let cameraButton = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(cameraButtonTapped(sender:)))
        if let font =  UIFont(name: "icomoon", size: 25) {
            cameraButton.setTitleTextAttributes([.font: font,
                                               .foregroundColor: UIColor.black],
                                              for: .normal)
            cameraButton.setTitleTextAttributes([.font: font,
                                                 .foregroundColor: UIColor.black],
                                                for: .selected)

        }
        
        navigationItem.rightBarButtonItem = cameraButton
    }
    
    @objc func cameraButtonTapped(sender: Any) {
        if presenter.weather != nil {
            ImagePickerHelper.pickImageActionSheet(viewController: self, delegate: self)
        } else {
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
            presenter.requestWeatherData(onSuccess: { [weak self] _ in
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                guard let `self` = self else { return }
                self.cameraButtonTapped(sender: sender)
            }, onFailure: { error in
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                Alert.show(message: error.localizedDescription)
            })
        }
    }
}

extension WeatherHistoryViewController: CLLocationManagerDelegate {
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print("Lat \(locations.first!.coordinate.latitude), Long\(locations.first!.coordinate.longitude)")
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

//MARK: UIImagePickerControllerDelegate
extension WeatherHistoryViewController: ImageEditorDelegate {
    func doneEditing(image: UIImage) {
        ImagesInteractor.saveImage(image: image)
        presenter.loadImages()
    }
}

extension WeatherHistoryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        picker.dismiss(animated: true, completion: {
            let vc = ImageEditorViewController()
            vc.image = image
            vc.weather = self.presenter.weather!
            vc.imageEditorDelegate = self
            vc.view.backgroundColor = .black
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        })
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension WeatherHistoryViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = collectionView?.indexPathForItem(at: location) else { return nil }
        guard let cell = collectionView?.cellForItem(at: indexPath) else { return nil }
        let vc = ImageViewerViewController()
        vc.image = presenter.images[indexPath.row]
        vc.hideDismissButton = true
        let preferedHeight = vc.image.suitableSize(widthLimit: UIScreen.main.bounds.width)?.height ?? 300
        vc.preferredContentSize = CGSize(width: 0.0, height: preferedHeight)
        previewingContext.sourceRect = cell.frame
        return vc
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        if let vc = viewControllerToCommit as? ImageViewerViewController {
            vc.hideDismissButton = false
            self.navigationController?.present(viewControllerToCommit, animated: true, completion: nil)
        }
    }

}
