//
//  MainTabBarController.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 27.08.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let news = NewsViewController()
        let newsIcon = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), selectedImage: UIImage(systemName: "newspaper.fill"))
        news.tabBarItem = newsIcon
        
        self.viewControllers = [news]
    }
}
