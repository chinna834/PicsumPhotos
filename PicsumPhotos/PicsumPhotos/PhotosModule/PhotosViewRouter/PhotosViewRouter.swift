//
//  PhotosViewRouter.swift
//  PicsumPhotos
//
//  Created by Chinna Addepally on 5/4/21.
//

import Foundation
import UIKit

class PhotosViewRouter: PhotosPresenterToRouterProtocol {
   
    static func createPhotosViewModule() -> PhotosViewController {
        
        let storyboard = Utilities().getStoryboard(storyboardName: Constants.mainStoryboardName)
        
        guard let photosViewController = storyboard.instantiateViewController(identifier: Constants.photosVCIdentifier) as? PhotosViewController else {
            return PhotosViewController() //Return View Controller instance without storyboard
        }
        
        let presenter: PhotosViewToPresenterProtocol & PhotosInteractorToPresenterProtocol = PhotosViewPresenter()
        let interactor: PhotosPresenterToInteractorProtocol = PhotosViewInteractor()
        let router: PhotosPresenterToRouterProtocol = PhotosViewRouter()
        
        photosViewController.presenter = presenter
        
        presenter.view = photosViewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return photosViewController
    }
    
}
