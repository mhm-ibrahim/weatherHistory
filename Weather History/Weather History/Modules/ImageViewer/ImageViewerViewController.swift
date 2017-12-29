//
//  ImageViewerViewController.swift
//  Weather History
//
//  Created by Mohamed Hamed on 12/28/17.
//  Copyright © 2017 Hamed. All rights reserved.
//

import UIKit

class ImageViewerViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    var image : UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        closeButton.roundCorners(withRadius: closeButton.frame.height / 2)
        initScrollView()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ImageViewerViewController: UIScrollViewDelegate {
    
    //Mark ScrollView
    func initScrollView() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        //Double Tap Zoom
        let doubleTap = UITapGestureRecognizer(target: self, action:  #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
        //Single Tap
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTapScrollView(recognizer:)))
        singleTap.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(singleTap)
        
        singleTap.require(toFail: doubleTap)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1 {
            scrollView.zoom(to: zoomRectForScale(scale: scrollView.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    @objc func handleSingleTapScrollView(recognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.zoomScale = 1
        }
    }

    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width  = imageView.frame.size.width  / scale
        let newCenter = imageView.convert(center, from: scrollView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
}
