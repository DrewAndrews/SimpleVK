//
//  CommunityCell.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 06.09.2021.
//

import UIKit
import Alamofire
import PromiseKit

class CommunityCell: UITableViewCell {
    
    let communityPhoto: UIImageView = {
        let communityPhoto = UIImageView()
        communityPhoto.translatesAutoresizingMaskIntoConstraints = false
        return communityPhoto
    }()
    
    private let communityName: UILabel = {
        let communityName = UILabel()
        communityName.translatesAutoresizingMaskIntoConstraints = false
        communityName.textColor = .black
        return communityName
    }()
    
    private let communityMembers: UILabel = {
        let communityMembers = UILabel()
        communityMembers.translatesAutoresizingMaskIntoConstraints = false
        communityMembers.textColor = .black
        return communityMembers
    }()
    
    private let roleTitle: UILabel = {
        let roleTitle = UILabel()
        roleTitle.translatesAutoresizingMaskIntoConstraints = false
        roleTitle.textColor = .black
        return roleTitle
    }()
    
    static var identifier = "CommunityCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(communityPhoto)
        contentView.addSubview(communityName)
        contentView.addSubview(communityMembers)
        contentView.addSubview(roleTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            communityPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            communityPhoto.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            communityPhoto.heightAnchor.constraint(equalToConstant: contentView.frame.height / 1.35),
            communityPhoto.widthAnchor.constraint(equalToConstant: contentView.frame.height / 1.35)
        ])
        communityPhoto.layer.masksToBounds = true
        communityPhoto.layer.cornerRadius = contentView.frame.height / 2.8
        
        NSLayoutConstraint.activate([
            communityName.leadingAnchor.constraint(equalTo: communityPhoto.trailingAnchor, constant: 5),
            communityName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            communityName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            communityMembers.leadingAnchor.constraint(equalTo: communityPhoto.trailingAnchor, constant: 5),
            communityMembers.topAnchor.constraint(equalTo: communityName.bottomAnchor, constant: 3)
        ])
        
        NSLayoutConstraint.activate([
            roleTitle.leadingAnchor.constraint(equalTo: communityMembers.trailingAnchor, constant: 3),
            roleTitle.topAnchor.constraint(equalTo: communityName.bottomAnchor, constant: 3)
        ])
    }
    
    func configure(community: Community) {
        loadCommunityPhoto(imageUrl: community.photo)
            .done { image in
                self.communityPhoto.image = image
            }
        communityName.text = community.name
        communityMembers.text = "\(community.membersCount)"
        roleTitle.text = community.isAdmin ? "Администратор" : "Пользователь"
    }
    
    private func loadCommunityPhoto(imageUrl: String) -> Promise<UIImage> {
        return Promise { seal in
            AF.request(imageUrl).responseData { response in
                guard let data = response.value, let image = UIImage(data: data) else {
                    let error = NSError(domain: "Loading image", code: 1, userInfo: [NSLocalizedDescriptionKey: "Can't load image"])
                    seal.reject(error)
                    return
                }
                seal.fulfill(image)
            }
        }
    }
}
