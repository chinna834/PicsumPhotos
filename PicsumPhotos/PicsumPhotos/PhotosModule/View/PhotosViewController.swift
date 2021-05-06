//
//  PhotosViewController.swift
//  PicsumPhotos
//
//  Created by Chinna Addepally on 5/4/21.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var imageHeaderLabel: UILabel!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var getImagesButton: UIButton!
    
    internal let minItemSpacing: CGFloat = 10.0
    internal let headerHeight: CGFloat   = 0
    
    var picsumPhotos: [PhotoObject] = []
    
    var presenter: PhotosViewToPresenterProtocol?
    
    //MARK: - Get More Image Button Clicked
    /**
        Send the request to load the next set of images
     */
    @IBAction func getMoreImagesButtonClicked(_ sender: Any) {
        getMorePicsumPhotos()
    }
    
    //MARK: - Configure Collection View
    /**
        Configure the collection view with the layout and registers the collection view cell
     */
    func configureCollectionView() {
        photosCollectionView.collectionViewLayout = PhotoCollectionViewFlowLayout()
        photosCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kPhotoCollectionViewCellIdentifier)
    }

    /**
     Requests Presenter to load more picsum photos
     */
    func getMorePicsumPhotos() {
        presenter?.getMorePicsumPhotos()
    }

    //MARK: - View did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureCollectionView()
        getMorePicsumPhotos()
    }
}

//MARK: - Updates from Presenter
extension PhotosViewController: PhotosPresenterToViewProtocol {
  
    /**
     Presenter sends the new picsum records received and updates the collection view
     */
    func addPicturesToView(photos: [PhotoObject]) {
        picsumPhotos.append(contentsOf: photos)
        photosCollectionView.reloadData()
    }
    
    /**
     Presenter updates the selected picsum photo author name by removing the vowels and collection updates the selected index path
     */
    func updateAuthorNameWithOutVowels(photoObject: PhotoObject, indexPath: IndexPath) {
        picsumPhotos[indexPath.item] = photoObject
        photosCollectionView.reloadItems(at: [indexPath])
    }
    
    func failedToGetPictures() {
        print("Not able to load pictures")
    }
}

//MARK: - Collection View Data source and delegate methods
extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picsumPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCollectionViewCellIdentifier, for: indexPath) as? PhotoCollectionViewCell,
              let photoObject = picsumPhotos[safe: indexPath.item] else {
            return PhotoCollectionViewCell()
        }
        
        cell.configureCell(with: photoObject)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedPhotoObject = picsumPhotos[safe: indexPath.row] else { return }
        presenter?.removeVowels(forAuthorNameIn: selectedPhotoObject, indexPath: indexPath)
    }
}
