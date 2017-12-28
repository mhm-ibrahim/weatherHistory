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
            return ""
        case .release:
            return ""
        }
    }
    
    static var baseApiURL: String {
        switch environment {
        case .debug:
            return baseURL + "/\(namespace)/\(APIVersion.v1)"
        case .release:
            return baseURL + "/\(namespace)/\(APIVersion.v1)"
        }
    }
    
}

extension Constants {
    
    static var namespace: String {
        return  "api"
    }
    
    public enum APIVersion: String {
        case
        v1 = "v1",
        v2 = "v2"
    }
    
}
