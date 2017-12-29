//
//  Alert.swift
//  Weather History
//
//  Created by Mohamed Hamed on 12/29/17.
//  Copyright © 2017 Hamed. All rights reserved.
//

import Foundation
import UIKit

public class Alert: NSObject {
    
    static func show(_ viewController: UIViewController? = nil,
                     message: String,
                     title: String? = nil) {
        
        var viewController = viewController
        if viewController == nil {
            viewController = UIApplication.shared.keyWindow?.rootViewController
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { action in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        viewController?.present(alert, animated: true, completion: nil)
    }
}
