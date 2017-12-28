//
//  WeatherHistoryViewController.swift
//  Weather History
//
//  Created by Mohamed Hamed on 12/28/17.
//  Copyright © 2017 Hamed. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherHistoryViewController: UIViewController {

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        requestWeatherData()
        ImagePickerHelper.pickImageActionSheet(viewController: self, delegate: self)
    }
    
    func requestWeatherData() {
        if let location = locationManager.location {
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            let currentLanguage = Bundle.main.preferredLocalizations.first ?? "en"
                
            WeatherService.current(lat: lat, long: long, units: "metric", language: currentLanguage, onSuccess: { weather in
                
            }, onFailure: { error in
                print(error.localizedDescription)
            })
        }
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
//        school.profileImage = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
