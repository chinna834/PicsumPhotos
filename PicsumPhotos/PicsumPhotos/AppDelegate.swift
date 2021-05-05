//
//  AppDelegate.swift
//  PicsumPhotos
//
//  Created by Chinna Addepally on 5/2/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let photosViewController = PhotosViewRouter.createPhotosViewModule()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = photosViewController
        window?.makeKeyAndVisible()

        return true
    }
}

