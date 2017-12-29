//
//  ImageEditorViewController.swift
//  Weather History
//
//  Created by Mohamed Hamed on 12/28/17.
//  Copyright © 2017 Hamed. All rights reserved.
//

import UIKit

public protocol ImageEditorDelegate {
    func doneEditing(image: UIImage)
}

class ImageEditorViewController: UIViewController {

    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var canvasImageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    var image: UIImage!
    var imageEditorDelegate: ImageEditorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setImageView(image: image)
        let emojiLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        emojiLabel.textAlignment = .center
        emojiLabel.text = "💃🏻"
        emojiLabel.font = UIFont.systemFont(ofSize: 80)
        addView(view: emojiLabel)
    }

    func setImageView(image: UIImage) {
        imageView.image = image
        let size = image.suitableSize(widthLimit: UIScreen.main.bounds.width)
        imageViewHeightConstraint.constant = (size?.height)!
    }
}

extension ImageEditorViewController {
    
    func addView(view: UIView) {
        view.center = canvasImageView.center
        self.canvasImageView.addSubview(view)
        addGestures(view: view)
    }
}
