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
    
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url, download_url
    }
    
    //Configured all the values as optionals
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        download_url = try values.decodeIfPresent(String.self, forKey: .download_url)
    }
    
    //MARK: - Construct the Download Image URL with custom width and height
    func getDownloadImageURL() -> String? {
        guard let userID = id else { return nil }
        let downloadImageURL = String(format: ServerKeys.getBaseDownloadURL, userID, Constants.thumbnailWidth, Constants.thumbnailHeight)
        return downloadImageURL
    }
    
    //MARK: - Update Author name by removing the vowels
    mutating func updateAuthorName(name: String) {
        author = name
    }
}
