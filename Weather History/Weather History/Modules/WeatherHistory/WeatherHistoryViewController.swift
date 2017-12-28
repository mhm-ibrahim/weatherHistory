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
// Pinterest layout ??!
//Use image viewer my image viewer

class WeatherHistoryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: WeatherHistoryPresenter!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = WeatherHistoryPresenter(viewController: self, collectionView: collectionView)
        setupLocationManager()
//        presenter.requestWeatherData(onSuccess: { weather in
//
//        }) { error in
//
//        }
//
//        let images = ImagesInteractor.loadImages()
//        ImagePickerHelper.pickImageActionSheet(viewController: self, delegate: self)
    }
    
   

}

extension WeatherHistoryViewController: CLLocationManagerDelegate {
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Lat \(locations.first?.coordinate.latitude), Long\(locations.first?.coordinate.longitude)")
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

//MARK: UIImagePickerControllerDelegate

extension WeatherHistoryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        picker.dismiss(animated: true, completion: nil)
        ImagesInteractor.saveImage(image: image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
