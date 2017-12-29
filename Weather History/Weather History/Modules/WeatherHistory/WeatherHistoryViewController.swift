//
//  WeatherHistoryViewController.swift
//  Weather History
//
//  Created by Mohamed Hamed on 12/28/17.
//  Copyright © 2017 Hamed. All rights reserved.
//

import UIKit
import CoreLocation
//TODO: use force touch
class WeatherHistoryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: WeatherHistoryPresenter!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavbar()
        setupLocationManager()
        presenter = WeatherHistoryPresenter(viewController: self, collectionView: collectionView)
        presenter.loadImages()
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
        ImagePickerHelper.pickImageActionSheet(viewController: self, delegate: self)
    }
}

extension WeatherHistoryViewController: CLLocationManagerDelegate {
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Lat \(locations.first!.coordinate.latitude), Long\(locations.first!.coordinate.longitude)")
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
