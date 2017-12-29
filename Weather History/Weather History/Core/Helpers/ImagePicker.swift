//
//  ImagePicker.swift
//  Weather History
//
//  Created by Mohamed Hamed on 12/28/17.
//  Copyright © 2017 Hamed. All rights reserved.
//

import Foundation
import UIKit

public class ImagePickerHelper: NSObject {
    
    static func pickImageActionSheet(viewController: UIViewController,
                                     delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)) {
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Photo", preferredStyle: .actionSheet)
        
        let photoLibraryAction = UIAlertAction(title: "Choose Existing Photo", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.pickImage(.photoLibrary,delegate: delegate, viewController: viewController)
        })
        
        let cameraAction = UIAlertAction(title: "Take New Photo", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.pickImage(.camera, delegate: delegate, viewController: viewController)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        optionMenu.addAction(photoLibraryAction)
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(cancelAction)
        
        viewController.present(optionMenu, animated: true, completion: nil)
    }
    
    static func pickImage(_ sourceType: UIImagePickerControllerSourceType,
                          delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate),
                          viewController: UIViewController) {
        let picker = UIImagePickerController()
        picker.delegate = delegate
        picker.sourceType = sourceType
        viewController.present(picker, animated: true, completion: nil)
    }
    
}
