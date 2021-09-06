//
//  Community.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 06.09.2021.
//

import Foundation

struct Community: Decodable {
    var photo: String
    var name: String
    var isAdmin: Bool
    var membersCount: Int
    
    enum CommunityCodingKey: String, CodingKey {
        case photo = "photo_50"
        case name
        case isAdmin = "is_admin"
        case membersCount = "members_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CommunityCodingKey.self)
        photo = try! container.decode(String.self, forKey: .photo)
        name = try! container.decode(String.self, forKey: .name)
        let is_admin = try! container.decode(Int.self, forKey: .isAdmin)
        isAdmin = is_admin == 1 ? true : false
        membersCount = try! container.decode(Int.self, forKey: .membersCount)
    }
}
