//
//  HNetwork.swift
//  Weather History
//
//  Created by Mohamed Hamed on 12/28/17.
//  Copyright © 2017 Hamed. All rights reserved.
//

import Foundation
import Alamofire

final class HNetwork {
    typealias DataResponseType  = DataResponse<Any>
    typealias OnSuccessCallback = (DataResponseType, Any)   -> ()
    typealias OnFailureCallback = (DataResponseType, Error) -> ()
    
    // MARK: Initializers
    private init() {}
    
    // MARK: Functions
    static func request(request: URLRequestConvertible,
                        onSuccess: OnSuccessCallback? = nil,
                        onFailure: OnFailureCallback? = nil) {
        requestWillBeSent(request: request)
        debugPrint(request)
        HSessionManager.current.request(request).validate().responseJSON { dataResponse in
            responseded(response: dataResponse)
            switch dataResponse.result {
            case .success(let result):
                onSuccess?(dataResponse, result)
            case .failure(let error):
                onFailure?(dataResponse, error)
            }
        }
    }
    
    // MARK: Private Functions
    private static func requestWillBeSent(request: URLRequestConvertible) {
        print("Sending Request.")
        print("=================================================")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    private static func responseded(response: DataResponseType) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
