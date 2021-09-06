//
//  PostsTable.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 30.08.2021.
//

import UIKit
import Alamofire

class PostsTable: UIViewController {
    
    var posts: [Post] = []
    var profiles: [Profile] = []
    var groups: [Group] = []
    
    private func loadNews() {
        let access_token = AuthManager.shared.accessToken!
        let method = "newsfeed.get"
        let filters = "post"
        
        let request = AF.request("https://api.vk.com/method/\(method)?filters=\(filters)&count=10&access_token=\(access_token)&v=5.131")
        request.responseDecodable(of: Response.self) { data in
            if let all = data.value {
                self.posts = all.items
                self.profiles = all.profiles
                self.groups = all.groups
                self.tableView.reloadData()
            }
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNews()
        
        tableView.dataSource = self
        tableView.backgroundColor = .lightGray
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        tableView.rowHeight = view.frame.height * 0.75
    }
}

extension PostsTable: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell else { return UITableViewCell() }
        let source = groups.first { $0.id == posts[indexPath.row].sourceId }!
        let sourceName = source.name
        let sourceImage = source.photo
        cell.configure(post: posts[indexPath.row], sourceName: sourceName, sourceImageUrl: sourceImage)
        cell.backgroundColor = .clear
        return cell
    }
}
