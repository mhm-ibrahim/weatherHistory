//
//  WeatherRouter.swift
//  Weather History
//
//  Created by Mohamed Hamed on 12/28/17.
//  Copyright © 2017 Hamed. All rights reserved.
//

import Foundation
import Alamofire

enum WeatherRouter: HURLRequestConvertible {
    
    case current(parameters: Parameters)
    
    var name: String { return "weather" }
    
    var path: String {
        switch self {
        case .current:    return "\(name)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .current:     return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .current(let parameters): return parameters
        default:                    return nil
        }
        
    }
}
