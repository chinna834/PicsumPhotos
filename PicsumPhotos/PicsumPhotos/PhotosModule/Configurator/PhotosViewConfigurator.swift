//
//  PhotosViewConfigurator.swift
//  PicsumPhotos
//
//  Created by Chinna Addepally on 5/4/21.
//

import Foundation
import UIKit

protocol PhotosViewToPresenterProtocol: AnyObject {
    var view: PhotosPresenterToViewProtocol? { get set }
    var interactor: PhotosPresenterToInteractorProtocol? { get set }
    var router: PhotosPresenterToRouterProtocol? { get set }
    var currentPage: Int { get set }
    func getMorePicsumPhotos()
    func removeVowels(forAuthorNameIn photoObject: PhotoObject, indexPath: IndexPath)
}

protocol PhotosPresenterToViewProtocol: AnyObject {
    func addPicturesToView(photos: [PhotoObject])
    func failedToGetPictures()
    func updateAuthorNameWithOutVowels(photoObject: PhotoObject, indexPath: IndexPath)
}

protocol PhotosPresenterToInteractorProtocol: AnyObject {
    var presenter: PhotosInteractorToPresenterProtocol? { get set }
    func getPicsumPhotos(page: Int)
}

protocol PhotosInteractorToPresenterProtocol: AnyObject {
    func fetchedPhotosOnSuccess(photos: [PhotoObject])
    func failedToFetchPhotos()
}

protocol PhotosPresenterToRouterProtocol: AnyObject {
    static func createPhotosViewModule() -> PhotosViewController
}
