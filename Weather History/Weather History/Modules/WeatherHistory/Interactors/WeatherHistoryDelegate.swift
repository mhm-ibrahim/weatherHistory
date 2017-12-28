//
//  WeatherHistoryDelegate.swift
//  Weather History
//
//  Created by Mohamed Hamed on 12/28/17.
//  Copyright © 2017 Hamed. All rights reserved.
//

import Foundation
import UIKit

class WeatherHistoryDelegate: NSObject, UICollectionViewDelegate {
    unowned var presenter: WeatherHistoryPresenter
    
    init(presenter: WeatherHistoryPresenter) {
        self.presenter = presenter
        super.init()
    }
}
