//
//  PostDetailViewController.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 10.09.2021.
//

import UIKit
import Alamofire

class PostDetailViewController: UIViewController {
    
    var source: Group = Group()
    var post: Post = Post()
    
    private var authorPhoto: UIImageView = {
        var authorPhoto = UIImageView()
        authorPhoto.translatesAutoresizingMaskIntoConstraints = false
        authorPhoto.layer.masksToBounds = true
        return authorPhoto
    }()
    
    private var authorNameLabel: UILabel = {
        var authorName = UILabel()
        authorName.translatesAutoresizingMaskIntoConstraints = false
        return authorName
    }()
    
    private var postTimeLabel: UILabel = {
        var postTimeLabel = UILabel()
        postTimeLabel.textColor = .black
        postTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return postTimeLabel
    }()
    
    private var textLabel: UILabel = {
        var textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .black
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
    private var contentImage: UIImageView = {
        var contentImage = UIImageView()
        contentImage.translatesAutoresizingMaskIntoConstraints = false
        return contentImage
    }()
    
    private var viewsCountLabel: UILabel = {
        var viewsCountLabel = UILabel()
        viewsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsCountLabel.textColor = .black
        return viewsCountLabel
    }()
    
    private var repostsCountLabel: UILabel = {
        var repostsCountLabel = UILabel()
        repostsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        repostsCountLabel.textColor = .black
        return repostsCountLabel
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ImageViewCollectionCell.self, forCellWithReuseIdentifier: ImageViewCollectionCell.identifier)
        return collectionView
    }()
    
    private func loadAuthorPhoto() {
        AF.request(source.photo).responseData { response in
            guard let data = response.value, let image = UIImage(data: data) else {
                return
            }
            self.authorPhoto.image = image
        }
    }
    
    var contentImages: [UIImage] = []
    
    private func loadContentImage() {
        guard let attachments = post.attachments else { return }
        let photos = attachments.filter { $0.type == "photo" }
        switch photos.count {
        case 1:
            AF.request(photos[0].photo!.sizes.last!.url).responseData { response in
                guard let data = response.value, let image = UIImage(data: data) else { return }
                self.contentImage.image = image
            }
        case 2...:
            for photo in photos {
                let url = photo.photo!.sizes.last!.url
                AF.request(url).responseData { response in
                    guard let data = response.value, let image = UIImage(data: data) else { return }
                    self.contentImages.append(image)
                    self.collectionView.reloadData()
                }
            }
        default:
            break
        }
    }
    
    private func addSubviews() {
        view.addSubview(authorPhoto)
        view.addSubview(authorNameLabel)
        view.addSubview(postTimeLabel)
        
        guard let attachments = post.attachments else { return }
        let photos = attachments.filter { $0.type == "photo" }
        switch photos.count {
        case 2...:
            view.addSubview(collectionView)
        default:
            view.addSubview(contentImage)
        }
        
        view.addSubview(textLabel)
        view.addSubview(viewsCountLabel)
        view.addSubview(repostsCountLabel)
    }
    
    private func initConstraints() {
        
        NSLayoutConstraint.activate([
            authorPhoto.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            authorPhoto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            authorPhoto.heightAnchor.constraint(equalToConstant: view.frame.height * 0.08),
            authorPhoto.widthAnchor.constraint(equalToConstant: view.frame.height * 0.08)
        ])
        
        NSLayoutConstraint.activate([
            authorNameLabel.leadingAnchor.constraint(equalTo: authorPhoto.trailingAnchor, constant: 5),
            authorNameLabel.topAnchor.constraint(equalTo: authorPhoto.topAnchor, constant: 3)
        ])

        NSLayoutConstraint.activate([
            postTimeLabel.leadingAnchor.constraint(equalTo: authorPhoto.trailingAnchor, constant: 5),
            postTimeLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 5)
        ])

        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: authorPhoto.bottomAnchor, constant: 5),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
        
        guard let attachments = post.attachments else { return }
        let photos = attachments.filter { $0.type == "photo" }
        switch photos.count {
        case 2...:
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 15),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.4)
            ])
            
            NSLayoutConstraint.activate([
                viewsCountLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
                viewsCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5)
            ])

            NSLayoutConstraint.activate([
                repostsCountLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
                repostsCountLabel.leadingAnchor.constraint(equalTo: viewsCountLabel.trailingAnchor, constant: 5)
            ])
        default:
            NSLayoutConstraint.activate([
                contentImage.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 15),
                contentImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                contentImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                contentImage.heightAnchor.constraint(equalToConstant: view.frame.height * 0.5)
            ])
            
            NSLayoutConstraint.activate([
                viewsCountLabel.topAnchor.constraint(equalTo: contentImage.bottomAnchor, constant: 10),
                viewsCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5)
            ])

            NSLayoutConstraint.activate([
                repostsCountLabel.topAnchor.constraint(equalTo: contentImage.bottomAnchor, constant: 10),
                repostsCountLabel.leadingAnchor.constraint(equalTo: viewsCountLabel.trailingAnchor, constant: 5)
            ])
        }
    }
    
    private func configurePost() {
        loadAuthorPhoto()
        
        authorNameLabel.text = source.name
        
        textLabel.text = post.text
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM HH:mm"
        let date = Date(timeIntervalSince1970: TimeInterval(post.postTime))
        postTimeLabel.text = dateFormatter.string(from: date)
        
        loadContentImage()
        
        viewsCountLabel.text = "Просмотров: \(post.views)"
        repostsCountLabel.text = "Репостов: \(post.reposts)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        collectionView.dataSource = self
        
        configurePost()
        
        addSubviews()
        initConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        authorPhoto.layer.cornerRadius = authorPhoto.frame.height / 2
    }
}

extension PostDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCollectionCell.identifier, for: indexPath) as? ImageViewCollectionCell else { return UICollectionViewCell()
        }
        cell.imageView.image = contentImages[indexPath.row]
        return cell
    }
}
