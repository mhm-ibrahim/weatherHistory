//
//  ImagesInteractor.swift
//  Weather History
//
//  Created by Mohamed Hamed on 12/28/17.
//  Copyright © 2017 Hamed. All rights reserved.
//

import Foundation
import UIKit

class ImagesInteractor {
    
    static func loadImages() -> [UIImage] {
        var objecBool : ObjCBool = true
        let exists = FileManager.default.fileExists(atPath: imagesDirectoryPath().path, isDirectory: &objecBool)
        if !exists {
            try? FileManager.default.createDirectory(at: imagesDirectoryPath(), withIntermediateDirectories: true, attributes: nil)
        }
        var images = [UIImage]()
        let imagesNames = try? FileManager.default.contentsOfDirectory(atPath: imagesDirectoryPath().path)
        imagesNames?.forEach {
            let data = FileManager.default.contents(atPath: imagesDirectoryPath().path + "/\($0)")
            images.append(UIImage(data: data!)!)
        }
        return images
    }
    
    static func saveImage(image: UIImage) {
        var imagePath = Date().description
        imagePath = imagePath.replacingOccurrences(of: " ", with: "")
        imagePath = imagesDirectoryPath().path + "/\(imagePath).png"
        let data = UIImagePNGRepresentation(image)
        FileManager.default.createFile(atPath: imagePath, contents: data, attributes: nil)
    }
    
    static func imagesDirectoryPath() -> URL {
        return documentsDirectory().appendingPathComponent("images")
    }

    static func documentsDirectory() -> URL {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirURL = URL(fileURLWithPath: paths.first!)
        return documentsDirURL
    }

}
