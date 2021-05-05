//
//  UIImageView+Extensions.swift
//  PicsumPhotos
//
//  Created by Chinna Addepally on 5/4/21.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

// MARK: - UIImageView extension
extension UIImageView {
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        NetworkManager.downloadImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                self.image = UIImage(data: data)
            case .failure(_):
                self.image = UIImage(named: "EmptyPlaceholder")
            }
        }
    }
}
