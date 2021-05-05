//
//  PhotoCollectionViewCell.swift
//  PicsumPhotos
//
//  Created by Chinna Addepally on 5/5/21.
//

import UIKit

let kPhotoCollectionViewCellIdentifier = "PicsumPhoto"

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoBackgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Configure Image View
        imageView.makeRoundCorners(byRadius: 10)
        
        //Configure Author Name Diagnolly
        authorNameLabel.transform = CGAffineTransform(rotationAngle: -.pi / 4)
        
        //Add Long Tap Gesture
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        photoBackgroundView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == .began { //Start the Label Animation
            let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            animation.repeatCount = .greatestFiniteMagnitude
            animation.values = [-20, 20]
            authorNameLabel.layer.add(animation, forKey: "moveBackForth")
        }
        else if sender.state == .ended { //End the Label Animation
            authorNameLabel.layer.removeAnimation(forKey: "moveBackForth")
        }
        else {
            print("Continue the animation")
        }
    }
    
    func configureCell(with photoObject: PhotoObject) {
        if let imageDownloadURLString = photoObject.download_url {
            imageView.loadImage(from: imageDownloadURLString)
        }
        
        authorNameLabel.text = photoObject.author ?? ""
    }

}
