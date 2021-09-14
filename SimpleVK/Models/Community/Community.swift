//
//  Community.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 06.09.2021.
//

import Foundation

struct Community: Decodable {
    var id: Int
    var photo: String
    var name: String
    var isMember: Bool
    var isAdmin: Bool
    var membersCount: Int
    var status: String
    
    enum CommunityCodingKey: String, CodingKey {
        case id
        case photo = "photo_50"
        case name
        case isMember = "is_member"
        case isAdmin = "is_admin"
        case membersCount = "members_count"
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CommunityCodingKey.self)
        id = try! container.decode(Int.self, forKey: .id)
        photo = try! container.decode(String.self, forKey: .photo)
        name = try! container.decode(String.self, forKey: .name)
        let is_member = try! container.decode(Int.self, forKey: .isMember)
        isMember = is_member == 1 ? true : false
        let is_admin = try! container.decode(Int.self, forKey: .isAdmin)
        isAdmin = is_admin == 1 ? true : false
        membersCount = try! container.decode(Int.self, forKey: .membersCount)
        status = try! container.decode(String.self, forKey: .status)
    }
}
