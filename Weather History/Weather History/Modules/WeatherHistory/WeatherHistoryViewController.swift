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
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        if let location = locationManager.location {
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            
            WeatherService.current(lat: lat, long: long, units: "metric", language: "en", onSuccess: {
                
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
}
