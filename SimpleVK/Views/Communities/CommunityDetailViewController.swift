//
//  CommunityDetailViewController.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 07.09.2021.
//

import UIKit
import PromiseKit
import Alamofire

class CommunityDetailViewController: UIViewController {
    
    var communityId: Int = 0
    
    var communityPhoto: UIImageView = {
        let communityPhoto = UIImageView()
        communityPhoto.translatesAutoresizingMaskIntoConstraints = false
        communityPhoto.layer.masksToBounds = true
        return communityPhoto
    }()
    
    var communityName: UILabel = {
        let communityName = UILabel()
        communityName.translatesAutoresizingMaskIntoConstraints = false
        communityName.textColor = .black
        return communityName
    }()
    
    var subscribersCountLabel: UILabel = {
        let subscribersCountLabel = UILabel()
        subscribersCountLabel.translatesAutoresizingMaskIntoConstraints = false
        subscribersCountLabel.textColor = .black
        return subscribersCountLabel
    }()
    
    var friendsInCommunityLabel: UILabel = {
        let friendsInCommunityLabel = UILabel()
        friendsInCommunityLabel.translatesAutoresizingMaskIntoConstraints = false
        friendsInCommunityLabel.textColor = .black
        return friendsInCommunityLabel
    }()
    
    let subscribeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.titleLabel?.textColor = .white
        return button
    }()
    
    let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.textColor = .black
        return statusLabel
    }()
    
    private func loadFriendsCountInCommunity() {
        let method = "groups.getMembers"
        let filter = "friends"
        let access_token = AuthManager.shared.accessToken!
        
        let url = URL(string: "https://api.vk.com/method/\(method)?group_id=\(communityId)&filter=\(filter)&access_token=\(access_token)&v=5.131")!
        AF.request(url).responseJSON { data in
            let json = try! JSONSerialization.jsonObject(with: data.data!, options: []) as! Dictionary<String, Any>
            let anotherData = json["response"] as! Dictionary<String, Any>
            let friendsCount = anotherData["count"] as! Int
            self.friendsInCommunityLabel.text = "Друзей: \(String(friendsCount))"
        }
    }
    
    @objc private func subscribeToCommunity() {
        if subscribeButton.titleLabel?.text == "Подписаться" {
            let method = "groups.join"
            let access_token = AuthManager.shared.accessToken!
            let url = "https://api.vk.com/method/\(method)?group_id=\(communityId)&access_token=\(access_token)&v=5.131"
            AF.request(url).responseJSON { data in
                let json = try! JSONSerialization.jsonObject(with: data.data!, options: []) as! Dictionary<String, Int>
                let response = json["response"]!
                if response == 1 {
                    self.subscribeButton.setTitle("Отписаться", for: .normal)
                    let communityListViewController = self.navigationController?.viewControllers[0] as! CommunitiesViewController
                    let index = communityListViewController.communityList.firstIndex { $0.id == self.communityId }!
                    communityListViewController.communityList[index].isMember = true
                }
            }
        } else {
            let method = "groups.leave"
            let access_token = AuthManager.shared.accessToken!
            let url = "https://api.vk.com/method/\(method)?group_id=\(communityId)&access_token=\(access_token)&v=5.131"
            AF.request(url).responseJSON { data in
                let json = try! JSONSerialization.jsonObject(with: data.data!, options: []) as! Dictionary<String, Int>
                let response = json["response"]!
                if response == 1 {
                    self.subscribeButton.setTitle("Подписаться", for: .normal)
                    let communityListViewController = self.navigationController?.viewControllers[0] as! CommunitiesViewController
                    let index = communityListViewController.communityList.firstIndex { $0.id == self.communityId }!
                    communityListViewController.communityList[index].isMember = false
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        subscribeButton.addTarget(self, action: #selector(subscribeToCommunity), for: .touchUpInside)
        
        loadFriendsCountInCommunity()

        view.addSubview(communityPhoto)
        view.addSubview(communityName)
        view.addSubview(subscribersCountLabel)
        view.addSubview(friendsInCommunityLabel)
        view.addSubview(subscribeButton)
        view.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            communityPhoto.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            communityPhoto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            communityPhoto.heightAnchor.constraint(equalToConstant: view.frame.height * 0.1),
            communityPhoto.widthAnchor.constraint(equalToConstant: view.frame.height * 0.1)
        ])
        
        NSLayoutConstraint.activate([
            communityName.leadingAnchor.constraint(equalTo: communityPhoto.trailingAnchor, constant: 10),
            communityName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            subscribersCountLabel.leadingAnchor.constraint(equalTo: communityPhoto.trailingAnchor, constant: 10),
            subscribersCountLabel.topAnchor.constraint(equalTo: communityName.bottomAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            friendsInCommunityLabel.topAnchor.constraint(equalTo: subscribersCountLabel.bottomAnchor, constant: 5),
            friendsInCommunityLabel.leadingAnchor.constraint(equalTo: communityPhoto.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            subscribeButton.leadingAnchor.constraint(equalTo: communityPhoto.trailingAnchor, constant: 10),
            subscribeButton.topAnchor.constraint(equalTo: friendsInCommunityLabel.bottomAnchor, constant: 5),
            subscribeButton.heightAnchor.constraint(equalToConstant: 35),
            subscribeButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.4)
        ])
        subscribeButton.layer.cornerRadius = 6
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: subscribeButton.bottomAnchor, constant: 10),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        communityPhoto.layer.cornerRadius = communityPhoto.frame.height / 2
    }
}
