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
        imageView.image = UIImage(named: "EmptyPlaceholder") //Adding default image
        
        //Configure Author Name Diagnolly
        authorNameLabel.transform = CGAffineTransform(rotationAngle: -.pi / 4)
        
        //Add Long Tap Gesture
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        photoBackgroundView.addGestureRecognizer(longPressGesture)
    }
    
    //MARK: - Animate the Author label when long pressed
    /**
     When the cell is long pressed author name is animated continousuly till the gesture state ends
     */
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == .began { //Start the Label Animation
            let animation = CAKeyframeAnimation(keyPath: "opacity")
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            animation.repeatCount = .greatestFiniteMagnitude
            animation.autoreverses = true
            animation.values = [1,0]
            authorNameLabel.layer.add(animation, forKey: "moveBackForth")
        }
        else if sender.state == .ended { //End the Label Animation
            authorNameLabel.layer.removeAnimation(forKey: "moveBackForth")
        }
    }
    
    //MARK: - Configure the cell with Author name and Image
    func configureCell(with photoObject: PhotoObject) {
        if let imageDownloadURLString = photoObject.getDownloadImageURL() {
            imageView.loadImage(from: imageDownloadURLString)
        }
        else {
            imageView.image = UIImage(named: "EmptyPlaceholder")
        }
        
        authorNameLabel.text = photoObject.author ?? ""
    }

}
