//
//  MainTabBarController.swift
//  Makestagram
//
//  Created by Asher Rosenblatt on 6/27/17.
//  Copyright © 2017 AVRTech. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController
{
    //MARK: - Properties
    let photoHelper = MGPhotoHelper()
    
    //MARK: - Implementation
    override func viewDidLoad()
    {
        super.viewDidLoad()
        delegate = self
        tabBar.unselectedItemTintColor = .black
        photoHelper.completionHandler = { image in
            print("Image recieved from picker")
            PostService.create(for: image)
        }
    }
}
extension MainTabBarController: UITabBarControllerDelegate
{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool
    {
        if viewController.tabBarItem.tag == 1
        {
            photoHelper.presentActionSheet(from: self)
            return false
        }
        return true
    }
}
