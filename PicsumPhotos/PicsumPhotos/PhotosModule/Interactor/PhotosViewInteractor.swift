//
//  PhotosViewInteractor.swift
//  PicsumPhotos
//
//  Created by Chinna Addepally on 5/4/21.
//

import Foundation

class PhotosViewInteractor: PhotosPresenterToInteractorProtocol {
    
    weak var presenter: PhotosInteractorToPresenterProtocol?
    
    /**
     Request the API to receive the Picsum photo records per page
     */
    func getPicsumPhotos(page: Int) {
        let requestObject = GetPicsumPhotosRequest(page: page)
        
        NetworkManager().send(r: requestObject) { [weak self] (success, response, error) in
            if success {
                guard let photos = response?.photos else {
                    self?.presenter?.failedToFetchPhotos()
                    return
                }
                self?.presenter?.fetchedPhotosOnSuccess(photos: photos)
            }
            else {
                self?.presenter?.failedToFetchPhotos()
            }
        }
    }    
}
