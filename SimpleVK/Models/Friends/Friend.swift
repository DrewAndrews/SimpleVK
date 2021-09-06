//
//  Friend.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 02.09.2021.
//

import Foundation

struct Friend: Decodable {
    let firstName: String
    let lastName: String
    let status: String
    let online: Int
    let lastSeen: LastSeen?
    
    enum FriendCodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case status
        case online
        case lastSeen = "last_seen"
    }
    
    struct LastSeen: Decodable {
        let platform: Int
        let time: Int
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: FriendCodingKeys.self)
        firstName = try! container.decode(String.self, forKey: .firstName)
        lastName = try! container.decode(String.self, forKey: .lastName)
        status = try! container.decode(String.self, forKey: .status)
        online = try! container.decode(Int.self, forKey: .online)
        lastSeen = try? container.decode(LastSeen.self, forKey: .lastSeen)
    }
}
