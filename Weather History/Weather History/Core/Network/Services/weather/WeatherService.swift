//
//  WeatherService.swift
//  Weather History
//
//  Created by Mohamed Hamed on 12/28/17.
//  Copyright © 2017 Hamed. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public class WeatherService {
    
    public static func current(lat: Double,
                               long: Double,
                               units: String,
                               language: String,
                            onSuccess: @escaping (Weather) -> (),
                            onFailure: @escaping (Error) -> ()) {
        let params: Parameters = ["lat": lat,
                                  "lon": long,
                                  "units": units,
                                  "lang": language,
                                  "appid" : Constants.weatherAPIKEY]
        let request = WeatherRouter.current(parameters: params)
        HNetwork.request(request: request, onSuccess: { dataResponse, result in
            guard let JSON = result as? [String: Any],
                let code = JSON["cod"] as? Int else { return }
            if code == 200 {
                let weather = Mapper<Weather>().map(JSONObject: result) ?? Weather()
                onSuccess(weather)
            } else {
                let serverError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Something went wrong!"])
                onFailure(serverError)
            }
            
        }) { dataResponse, error in
            onFailure(error)
        }
    }
    
}
