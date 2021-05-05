//
//  PhotosViewController.swift
//  PicsumPhotos
//
//  Created by Chinna Addepally on 5/4/21.
//

import UIKit

class PhotosViewController: UIViewController {
    
    var presenter: PhotosViewToPresenterProtocol?
    
    func getMorePicsumPhotos() {
        presenter?.getMorePicsumPhotos()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getMorePicsumPhotos()
    }
}

extension PhotosViewController: PhotosPresenterToViewProtocol {
  
    func addPicturesToView(photos: [PhotoObject]) {
        print(photos.count)
    }
    
    func failedToGetPictures() {
        print("Not able to load pictures")
    }
}
