//
//  CommunityDetailViewController.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 07.09.2021.
//

import UIKit

class CommunityDetailViewController: UIViewController {
    
    var communityPhoto: UIImageView = {
        let communityPhoto = UIImageView()
        communityPhoto.translatesAutoresizingMaskIntoConstraints = false
        return communityPhoto
    }()
    var communityName: UILabel = {
        let communityName = UILabel()
        communityName.translatesAutoresizingMaskIntoConstraints = false
        communityName.textColor = .black
        return communityName
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(communityPhoto)
        view.addSubview(communityName)
        
        NSLayoutConstraint.activate([
            communityPhoto.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            communityPhoto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            communityPhoto.heightAnchor.constraint(equalToConstant: view.frame.height * 0.1),
            communityPhoto.widthAnchor.constraint(equalToConstant: view.frame.height * 0.1)
        ])
        communityPhoto.layer.masksToBounds = true
        communityPhoto.layer.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            communityName.leadingAnchor.constraint(equalTo: communityPhoto.trailingAnchor, constant: 10),
            communityName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
        
    }
}
