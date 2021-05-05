//
//  UIImage+Extensions.swift
//  PicsumPhotos
//
//  Created by Chinna Addepally on 5/5/21.
//

import Foundation
import UIKit

extension UIImage {
    
    //MARK: Renders the Image to specific size with Aspect fill
    func scaleUIImageTo(size: CGSize) -> UIImage? {
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    //MARK: Renders the Image to specific height
    func resizeImage(newHeight: CGFloat) -> UIImage? {
        
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
