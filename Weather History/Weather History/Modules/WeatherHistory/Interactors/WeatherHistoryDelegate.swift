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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ImageViewerViewController()
        vc.image = presenter.images[indexPath.item]
        vc.view.backgroundColor = .black
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        presenter.viewController.present(vc, animated: true, completion: nil)
    }
}
