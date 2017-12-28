//
//  HSessionManager.swift
//  Weather History
//
//  Created by Mohamed Hamed on 12/28/17.
//  Copyright © 2017 Hamed. All rights reserved.
//

import Foundation
import Alamofire

final class HSessionManager: NSObject {
    
    private static var sessionManager: SessionManager?
    
    static var current: SessionManager {
        if sessionManager == nil {
            sessionManager = SessionManager()
        }
        
        let token = UserDefaults.object(forKey: .token) as? String ?? ""
        sessionManager!.adapter = AccessTokenAdapter(token: token)
        
        return sessionManager!
    }
    
    private override init() {
        super.init()
    }
    
    static func cancelAllRequests() {
        sessionManager?.session.invalidateAndCancel()
        sessionManager = nil
    }
}

class AccessTokenAdapter: RequestAdapter {
    private let token: String
    
    init(token: String) {
        self.token = token
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(Constants.baseURL) {
            urlRequest.setValue("Bearer" + token, forHTTPHeaderField: "Authorization")
        }
        
        debugPrint(urlRequest)
        return urlRequest
    }
}
