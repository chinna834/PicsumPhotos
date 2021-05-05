//
//  PhotosViewPresenter.swift
//  PicsumPhotos
//
//  Created by Chinna Addepally on 5/4/21.
//

import Foundation

class PhotosViewPresenter: PhotosViewToPresenterProtocol {
    
    weak var view: PhotosPresenterToViewProtocol?
    var interactor: PhotosPresenterToInteractorProtocol?
    var router: PhotosPresenterToRouterProtocol?
    var currentPage: Int = 0
    
    func getMorePicsumPhotos() {
        currentPage += 1
        interactor?.getPicsumPhotos(page: currentPage)
    }
    
    func removeVowels(forAuthorNameIn photoObject: PhotoObject, indexPath: IndexPath) {
        guard let authorName = photoObject.author else { return }
        let updatedAuthorName = String(authorName.filter({!"aAeEiIoOuU".contains(String($0))}))
        
        print("\(authorName) is \(updatedAuthorName)")
        
        var updatedPhotoObject = photoObject
        updatedPhotoObject.updateAuthorName(name: updatedAuthorName)
        
        view?.updateAuthorNameWithOutVowels(photoObject: updatedPhotoObject, indexPath: indexPath)
    }
}

extension PhotosViewPresenter: PhotosInteractorToPresenterProtocol {
    func fetchedPhotosOnSuccess(photos: [PhotoObject]) {
        view?.addPicturesToView(photos: photos)
    }
    
    func failedToFetchPhotos() {
        currentPage -= 1 //Since the current page is not loaded revert the page
        view?.failedToGetPictures()
    }
}
