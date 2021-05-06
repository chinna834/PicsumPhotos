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
    
    /**
     Increase the current page to track the next set of picsum photos download
     */
    func getMorePicsumPhotos() {
        currentPage += 1
        interactor?.getPicsumPhotos(page: currentPage)
    }
    
    /**
     Remove vowels either through filter or sends the request to remove the vowels recursively and Updates the view
     */
    func removeVowels(forAuthorNameIn photoObject: PhotoObject, indexPath: IndexPath) {
        guard let authorName = photoObject.author else { return }
//        let updatedAuthorName = String(authorName.filter({!"aAeEiIoOuU".contains(String($0))}))
        
        var updatedAuthorName = ""
        var currentIndex = 0
        removeVowel(index: &currentIndex, name: authorName, updatedName: &updatedAuthorName)
        
        var updatedPhotoObject = photoObject
        updatedPhotoObject.updateAuthorName(name: updatedAuthorName)
        
        view?.updateAuthorNameWithOutVowels(photoObject: updatedPhotoObject, indexPath: indexPath)
    }
}

//MARK: - Send the Updates to View after receiving the updates from presenter
extension PhotosViewPresenter: PhotosInteractorToPresenterProtocol {
    func fetchedPhotosOnSuccess(photos: [PhotoObject]) {
        view?.addPicturesToView(photos: photos)
    }
    
    func failedToFetchPhotos() {
        currentPage -= 1 //Since the current page is not loaded revert the page
        view?.failedToGetPictures()
    }
}

//Remove Vowels Recursively
extension PhotosViewPresenter {
    /**
     Remove the vowels recursively from the Author name
     */
    @discardableResult func removeVowel(index: inout Int, name: String, updatedName: inout String) -> String {
        if index == name.count {
            return updatedName
        }
        
        let indexCharacter = name[name.index(name.startIndex, offsetBy: index)]
        if (!"aAeEiIoOuU".contains(indexCharacter)) {
            updatedName.append(indexCharacter)
        }
        
        index += 1
        
        return removeVowel(index: &index, name: name, updatedName: &updatedName)
    }
}
