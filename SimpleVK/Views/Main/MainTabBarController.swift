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
        
        let news = PostsTable()
        let newsNC = UINavigationController(rootViewController: news)
        newsNC.navigationBar.topItem?.title = "News"
        let newsIcon = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), selectedImage: UIImage(systemName: "newspaper.fill"))
        news.tabBarItem = newsIcon
        
        let friends = FriendsViewController()
        let friendsNC = UINavigationController(rootViewController: friends)
        let friendsIcon = UITabBarItem(title: "Friends", image: UIImage(systemName: "person.2"), selectedImage: UIImage(systemName: "person.2.fill"))
        friends.tabBarItem = friendsIcon
        
        let communties = CommunitiesViewController()
        let communtiesNC = UINavigationController(rootViewController: communties)
        communtiesNC.navigationBar.topItem?.title = "Communties"
        let communtiesIcon = UITabBarItem(title: "Communties", image: UIImage(systemName: "person.3"), selectedImage: UIImage(systemName: "person.3.fill"))
        communties.tabBarItem = communtiesIcon
        
        self.viewControllers = [newsNC, communtiesNC, friendsNC]
    }
}
