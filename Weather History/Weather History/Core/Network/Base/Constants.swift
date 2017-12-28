//
//  Constants.swift
//  Weather History
//
//  Created by Mohamed Hamed on 12/28/17.
//  Copyright © 2017 Hamed. All rights reserved.
//

import Foundation
enum Environment {
    case debug
    case release
    
    static var current: Environment {
        return .debug
    }
}

struct Constants {
    private init() {}
    
    static let environment = Environment.current
    
    static var baseURL: String {
        switch environment {
        case .debug:
            return "http://api.openweathermap.org"
        case .release:
            return "http://api.openweathermap.org"
        }
    }
    
    static var baseApiURL: String {
        switch environment {
        case .debug:
            return baseURL + "/\(namespace)/\(APIVersion.v25.rawValue)"
        case .release:
            return baseURL + "/\(namespace)/\(APIVersion.v25.rawValue)"
        }
    }
    
}

extension Constants {
    static var namespace: String {
        return  "data"
    }
    
    public enum APIVersion: String {
        case
        v25 = "2.5"
    }
}

extension Constants {
    static var weatherAPIKEY: String {
        return "be41eee34a0fcd23293be278c0333f88"
    }
}
