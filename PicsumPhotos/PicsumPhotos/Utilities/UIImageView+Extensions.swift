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
    
    func makeRoundCorners(byRadius radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    /**
     Returns the image if it is available in Cache or downloads the image and updates the cache. Cache key is identified by a URL and return the image
     */
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject), let picsumImage = imageFromCache as? UIImage {
            image = picsumImage
            return
        }
        
        NetworkManager.downloadImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                DispatchQueue.main.async() { [weak self] in
                    self?.image = imageToCache
                }
            case .failure(_):
                DispatchQueue.main.async { [weak self] in
                    self?.image = UIImage(named: "EmptyPlaceholder")
                }
            }
        }
    }
}
