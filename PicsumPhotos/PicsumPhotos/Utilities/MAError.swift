//
//  MAError.swift
//  PicsumPhotos
//
//  Created by Chinna Addepally on 5/4/21.
//

import Foundation

struct MAError: Error {
    var errorDescription: String!
    var errorCode: Int!
    var serverError: Error?
    
    init(description: String, responseCode: Int, error: Error?) {

        self.errorDescription = description
        self.errorCode = responseCode
        self.serverError = error
    }
}
