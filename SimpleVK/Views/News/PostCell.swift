//
//  NewsTableViewCell.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 28.08.2021.
//

import UIKit
import Alamofire

class PostCell: UITableViewCell {
    
    private let avatarImage: UIImageView = {
        let avatarImage = UIImageView()
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        return avatarImage
    }()
    
    private let authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.adjustsFontSizeToFitWidth = true
        authorLabel.minimumScaleFactor = 0.2
        return authorLabel
    }()

    private let publishedDateLabel: UILabel = {
        let publishedDateLabel = UILabel()
        publishedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        publishedDateLabel.adjustsFontSizeToFitWidth = true
        publishedDateLabel.minimumScaleFactor = 0.2
        return publishedDateLabel
    }()
    
    private let postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.translatesAutoresizingMaskIntoConstraints = false
        return postImage
    }()
    
    private let postText: UILabel = {
        let postText = UILabel()
        postText.translatesAutoresizingMaskIntoConstraints = false
        postText.numberOfLines = 5
        return postText
    }()
    
    private let imageCountLabel: UILabel = {
        let imageCountLabel = UILabel()
        imageCountLabel.translatesAutoresizingMaskIntoConstraints = false
        return imageCountLabel
    }()
    
    static var identifier = "PostCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(authorLabel)
        contentView.addSubview(avatarImage)
        contentView.addSubview(publishedDateLabel)
        contentView.addSubview(postText)
        contentView.addSubview(postImage)
        contentView.addSubview(imageCountLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        
        NSLayoutConstraint.activate([
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            avatarImage.widthAnchor.constraint(equalToConstant: contentView.frame.height / 11),
            avatarImage.heightAnchor.constraint(equalToConstant: contentView.frame.height / 11)
            
        ])
        avatarImage.layer.masksToBounds = true
        avatarImage.layer.borderWidth = 0.2
        avatarImage.layer.borderColor = UIColor.gray.cgColor
        avatarImage.layer.cornerRadius = contentView.frame.height / 22
        
        NSLayoutConstraint.activate([
            authorLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 5),
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
            authorLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height / 25)
        ])
        
        NSLayoutConstraint.activate([
            publishedDateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 3),
            publishedDateLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 5),
            publishedDateLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height / 25)
        ])
        
        NSLayoutConstraint.activate([
            postText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            postText.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 4),
            postText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: postText.bottomAnchor, constant: 3),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            // postImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            imageCountLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 3),
            imageCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imageCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5),
            imageCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3)
        ])
    }
    
    func configure(post: Post, sourceName: String, sourceImageUrl: String) {
        authorLabel.text = sourceName
        AF.request(sourceImageUrl).response { response in
            switch response.result {
            case .success(let data):
                self.avatarImage.image = UIImage(data: data!)
            case .failure(let error):
                print(error)
            }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM HH:mm"
        let date = Date(timeIntervalSince1970: TimeInterval(post.postTime))
        publishedDateLabel.text = dateFormatter.string(from: date)
        
        postText.text = post.text
        
        if let type = post.attachments?[0].type, type == "photo" {
            let imageUrl = post.attachments![0].photo!.sizes[4].url
            AF.request(imageUrl).response { response in
                switch response.result {
                case .success(let data):
                    self.postImage.image = UIImage(data: data!)
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        if let attachments = post.attachments {
            let imagesCount = attachments.filter { $0.type == "photo" }.count
            imageCountLabel.text = "Images: \(imagesCount)"
        } else {
            imageCountLabel.text = "Images: 0"
        }
    }
}
