//
//  GetPicsumPhotosRequestResponse.swift
//  PicsumPhotos
//
//  Created by Chinna Addepally on 5/4/21.
//

import Foundation

struct GetPicsumPhotosRequest: RequestObject {

    typealias response = GetPicsumPhotosResponse
    
    var host: String? // No host present in this case
    var path: String?
    var url: URL?
    var body: [[String: Any]]?
    var method: String
    var header: [[String : Any]]?

    /**
     Construct the URL request for Picsum photos API
     */
    init(page: Int) {
        let urlPath = String(format: ServerKeys.getPicsumPhotosPath, "\(page)", "\(Constants.picsumPhotosLimit)")
        url = URL(string: urlPath)
        method = HTTPMethod.get.rawValue
    }
    
}

struct GetPicsumPhotosResponse: DecodableResponse {
    
    var photos: [PhotoObject] = []
    var error: MAError?
    
    /**
     Parse the Picsum photo objects using decodable protocol
     */
    static func parse(data: Data, success: Bool) -> GetPicsumPhotosResponse? {
        
        var response = GetPicsumPhotosResponse()
        
        if success {
            do {
                response.photos = try JSONDecoder().decode([PhotoObject].self, from: data)
            } catch {
                print(error)
            }
        }
        else {
            let err = MAError(description: Constants.commonError, responseCode: 0, error: nil)
            response.error = err
        }
        
        return response
    }
    
}
