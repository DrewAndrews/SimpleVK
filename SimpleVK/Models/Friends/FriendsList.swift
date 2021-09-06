//
//  Friend.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 02.09.2021.
//

import Foundation

struct FriendsList: Decodable {
    
    var items: [Friend]
    
//    private struct JSONFriend: Decodable {
//        let first_name: String
//        let last_name: String
//        let status: String
//        let online: Int
//        let last_seen: JSONLastSeen?
//    }
//
//    private struct JSONLastSeen: Decodable {
//        let platform: Int
//        let time: Int
//    }
    
    private enum ResponseCodingKey: CodingKey {
        case response
    }
    
    private enum ContentCodingKey: CodingKey {
        case count
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: ResponseCodingKey.self)
        let contentContainer = try! container.nestedContainer(keyedBy: ContentCodingKey.self, forKey: .response)
        items = try! contentContainer.decode([Friend].self, forKey: .items)
    }
}
