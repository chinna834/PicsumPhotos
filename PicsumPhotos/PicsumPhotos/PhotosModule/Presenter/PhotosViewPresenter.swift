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
