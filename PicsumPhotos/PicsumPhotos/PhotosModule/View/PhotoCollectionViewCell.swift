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
        // Initialization code
    
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        authorNameLabel.transform = CGAffineTransform(rotationAngle: -.pi / 4)
    }
    
    func configureCell(with photoObject: PhotoObject) {
        if let imageDownloadURLString = photoObject.download_url {
            imageView.loadImage(from: imageDownloadURLString)
        }
        
        authorNameLabel.text = photoObject.author ?? ""
    }

}
