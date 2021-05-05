//
//  Utilities.swift
//  PicsumPhotos
//
//  Created by Chinna Addepally on 5/4/21.
//

import Foundation
import UIKit

class Utilities {
    
    func getStoryboard(storyboardName: String) -> UIStoryboard {
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
        return storyboard
    }
}
