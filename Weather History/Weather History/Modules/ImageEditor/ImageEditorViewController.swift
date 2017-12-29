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
    @IBOutlet weak var dismissButton: UIButton!
    
    var image: UIImage!
    var imageEditorDelegate: ImageEditorDelegate?
    var weather: Weather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setImageView(image: image)
        dismissButton.roundCorners(withRadius: dismissButton.frame.height / 2)
        addWeatherCard()
    }

    func addWeatherCard() {
        let weatherCard = WeatherInfoCard(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
        weatherCard.tempLabel.text = weather.temp?.temp.description
        weatherCard.cityLabel.text = weather.city
        weatherCard.weatherConditionLabel.text = weather.info?.description
        addView(view: weatherCard)
    }
    
    func setImageView(image: UIImage) {
        imageView.image = image
        let size = image.suitableSize(widthLimit: UIScreen.main.bounds.width)
        imageViewHeightConstraint.constant = (size?.height)!
    }
}

extension ImageEditorViewController {

    @IBAction func saveButtonTapped(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(canvasView.toImage(),self, #selector(ImageEditorViewController.image(_:withPotentialError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, withPotentialError error: NSErrorPointer, contextInfo: UnsafeRawPointer) {
        let alert = UIAlertController(title: "Image Saved", message: "Image successfully saved to Photos library", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        let activity = UIActivityViewController(activityItems: [canvasView.toImage()], applicationActivities: nil)
        present(activity, animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        let img = self.canvasView.toImage()
        imageEditorDelegate?.doneEditing(image: img)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ImageEditorViewController {
    
    func addView(view: UIView) {
        //view.center = canvasImageView.center
        self.canvasImageView.addSubview(view)
        addGestures(view: view)
    }
}
