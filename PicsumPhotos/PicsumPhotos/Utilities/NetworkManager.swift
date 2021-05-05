//
//  NetworkManager.swift
//  PicsumPhotos
//
//  Created by Chinna Addepally on 5/4/21.
//

import Foundation
import Security
import SystemConfiguration

protocol RequestObject {
    var host: String? {get}
    var path: String? {get}
    var url: URL {get}
    var method: String {get}
    var header: [[String: Any]]? {get}
    var body: [[String: Any]]? {get}
    
    associatedtype response: DecodableResponse
}

protocol DecodableResponse {
    static func parse(data: Data, success: Bool) -> Self?
}

typealias Completion<T: RequestObject> = (_ success: Bool,_ response: T.response?,_ error: MAError?) -> Void

public enum Result<T> {
    case success(T)
    case failure(Error)
}

class NetworkManager: NSObject {
    
    //MARK:- Create URL Request
    func createURLRequest<T: RequestObject>(r: T) -> URLRequest? {
        
        var urlRequest = URLRequest(url: r.url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let headerKeys = r.header {
            for eachHeader in headerKeys {
                if let key = eachHeader.keys.first, let value = eachHeader[key] as? String {
                    urlRequest.setValue(value, forHTTPHeaderField: key)
                }
            }
        }

        if let body = r.body, let data = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) {
            let bodyString = String.init(data: data, encoding: .utf8)
            urlRequest.httpBody = bodyString?.data(using: .utf8)
        }
        urlRequest.httpMethod = r.method
        
        return urlRequest
    }
    
    //MARK: Send Request
    func send<T:RequestObject>(r:T,completion:@escaping Completion<T>) {
        
        guard let request = createURLRequest(r: r) else {
            completion(false, nil, MAError(description: Constants.errorInRequest, responseCode: 0, error: nil))
            return
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let r = response as? HTTPURLResponse else{
                completion(false, nil, MAError(description: Constants.commonError, responseCode: 0, error: error))
                return
            }
            
            guard r.statusCode == 200 else {
                completion(false, nil, MAError(description: Constants.commonError, responseCode: r.statusCode, error: error))
                return
            }
            
            guard let responseData = data else {
                completion(false, nil, MAError(description: Constants.commonError, responseCode: r.statusCode, error: error))
                return
            }
            
            let res = T.response.parse(data: responseData, success: true)
            completion(true, res, nil)
        }
        task.resume()
    }
    
    //MARK: Download Image
    static func downloadImage(url: URL, completion: @escaping (Result<Data>) -> Void) {
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async() {
                completion(.success(data))
            }
        }

        session.resume()
    }
}
