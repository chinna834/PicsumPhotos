//
//  Constants.swift
//  PicsumPhotos
//
//  Created by Chinna Addepally on 5/4/21.
//

import Foundation

enum HTTPMethod: String {
    case post = "POST",
         get = "GET",
         put = "UPDATE",
         delete = "DELETE"
}

struct Constants {
    
    static let picsumPhotosLimit = 100
    static let thumbnailWidth = 165
    static let thumbnailHeight = 110
    
    //Storyboard
    static let mainStoryboardName = "Main"
    
    //View Controller Identifier
    static let photosVCIdentifier = "PhotosViewController"
    
    //Common
    static let commonError = "Something went wrong. Please try again."
    static let errorInRequest = "Error sending request"
    
}
