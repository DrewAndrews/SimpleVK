//
//  FriendsViewController.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 27.08.2021.
//

import UIKit
import Alamofire

class FriendsViewController: UIViewController {
    
    private var friends: [Friend] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private func loadFriends() {
        let loadFriendsIdsOperation = BlockOperation()
        loadFriendsIdsOperation.addExecutionBlock {
            print(Thread.current)
            let method = "friends.get"
            let access_token = AuthManager.shared.accessToken!
            let fields = "nickname,status,last_seen,online"
            let url = "https://api.vk.com/method/\(method)?fields=\(fields)&name_case=nom&access_token=\(access_token)&v=5.131"
            
            let request = AF.request(url)
            request.responseDecodable(of: FriendsList.self) { data in
                if let friendsList = data.value?.items {
                    self.friends = friendsList
                }
            }
        }
        
        let updateTableOperation = BlockOperation()
        updateTableOperation.addDependency(loadFriendsIdsOperation)
        updateTableOperation.addExecutionBlock {
            print(Thread.current)
            print(self.friends)
        }
        
        let operationQueue = OperationQueue()
        operationQueue.addOperation(loadFriendsIdsOperation)
        operationQueue.addOperation(updateTableOperation)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        loadFriends()
        print("Friends view controller did load")
        
        view.addSubview(tableView)
    }
}

extension FriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
