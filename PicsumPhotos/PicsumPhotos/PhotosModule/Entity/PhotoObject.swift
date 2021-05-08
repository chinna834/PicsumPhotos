//
//  PhotoObject.swift
//  PicsumPhotos
//
//  Created by Chinna Addepally on 5/4/21.
//

import Foundation

struct PhotoObject: Decodable {
    var id: String?
    var author: String?
    var width: Int?
    var height: Int?
    var url: String?
    var download_url: String? //Ignore the download image URL to avoid the default scaling image which is very high in resolution
    
    //MARK: - Construct the Download Image URL with custom width and height
    func getDownloadImageURL() -> String? {
        guard let userID = id else { return nil }
        let downloadImageURL = String(format: ServerKeys.getBaseDownloadURL, userID, "\(Constants.thumbnailWidth)", "\(Constants.thumbnailHeight)")
        return downloadImageURL
    }
    
    //MARK: - Update Author name by removing the vowels
    mutating func updateAuthorName(name: String) {
        author = name
    }
}
