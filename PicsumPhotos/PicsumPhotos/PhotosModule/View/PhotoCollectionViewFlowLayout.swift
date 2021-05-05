//
//  PhotoCollectionViewFlowLayout.swift
//  PicsumPhotos
//
//  Created by Chinna Addepally on 5/5/21.
//

import UIKit

class PhotoCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 0 distance between each cell, and vertical layout
     */
    func setupLayout() {
        minimumInteritemSpacing = 10
        minimumLineSpacing = 12
        scrollDirection = .horizontal
        sectionInset.left = 2
        sectionInset.right = 2
        sectionInset.top = 8
    }
    
    func itemWidth() -> CGFloat {
        return 175
    }
    
    func itemHeight() -> CGFloat {
        return 110
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height: itemHeight())
        }
        get {
            return CGSize(width: itemWidth(), height: itemHeight())
        }
    }
}
