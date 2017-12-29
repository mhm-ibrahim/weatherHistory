//
//  GradientView.swift
//  Weather History
//
//  Created by Mohamed Hamed on 12/29/17.
//  Copyright © 2017 Hamed. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    @IBInspectable public var gradientFromtop: Bool = true
    
    var gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if gradientFromtop == false {
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor(white: 0.0, alpha: 0.5).cgColor]
        } else {
            gradientLayer.colors = [UIColor(white: 0.0, alpha: 0.5).cgColor, UIColor.clear.cgColor]
        }
        
        gradientLayer.locations = [NSNumber(value: 0.0 as Float), NSNumber(value: 1.0 as Float)]
        backgroundColor = UIColor.clear
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
}
