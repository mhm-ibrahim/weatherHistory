//
//  WeatherHistoryDataSource.swift
//  Weather History
//
//  Created by Mohamed Hamed on 12/28/17.
//  Copyright © 2017 Hamed. All rights reserved.
//

import Foundation
import UIKit

class WeatherHistoryDataSource: NSObject, UICollectionViewDataSource {
    
    unowned var presenter: WeatherHistoryPresenter
    
    init(presenter: WeatherHistoryPresenter) {
        self.presenter = presenter
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
}
