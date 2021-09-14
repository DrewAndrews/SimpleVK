//
//  CommunitiesViewController.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 27.08.2021.
//

import UIKit
import Alamofire
import PromiseKit

class CommunitiesViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CommunityCell.self, forCellReuseIdentifier: CommunityCell.identifier)
        return tableView
    }()
    
    var communityList: [Community] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCommunityList()
            .done { communityList in
                self.communityList = communityList.items
                self.tableView.reloadData()
            }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none

        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        tableView.rowHeight = view.frame.height * 0.098
    }
    
    private func loadCommunityList() -> Promise<CommunityList> {
        return Promise { seal in
            let method = "groups.get"
            let extended = 1
            let fields = "members_count,status"
            let access_token = AuthManager.shared.accessToken!
            
            let url = URL(string: "https://api.vk.com/method/\(method)?fields=\(fields)&extended=\(extended)&access_token=\(access_token)&v=5.131")!
            AF.request(url).responseDecodable(of: CommunityList.self) { response in
                guard let data = response.value else {
                    let error = NSError(domain: "Invalid json", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
                    seal.reject(error)
                    return
                }
                seal.fulfill(data)
            }
        }
    }
}

extension CommunitiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommunityCell.identifier, for: indexPath) as? CommunityCell else { return UITableViewCell() }
        cell.configure(community: communityList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let community = communityList[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! CommunityCell
        
        let communityDetailViewController = CommunityDetailViewController()
        communityDetailViewController.communityName.text = community.name
        communityDetailViewController.communityPhoto.image = cell.communityPhoto.image
        communityDetailViewController.subscribersCountLabel.text = "Участников: \(community.membersCount)"
        communityDetailViewController.communityId = community.id
        communityDetailViewController.subscribeButton.setTitle(community.isMember ? "Отписаться" : "Подписаться", for: .normal)
        communityDetailViewController.statusLabel.text = community.status

        navigationController?.pushViewController(communityDetailViewController, animated: true)
    }
}
