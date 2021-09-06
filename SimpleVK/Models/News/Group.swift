//
//  Group.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 29.08.2021.
//

import Foundation

struct Group: Decodable {
    var id: Int
    var name: String
    var photo: String
    
    enum GroupCodingKey: String, CodingKey {
        case id
        case name
        case photo = "photo_50"
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: GroupCodingKey.self)
        id = try! container.decode(Int.self, forKey: .id)
        name = try! container.decode(String.self, forKey: .name)
        photo = try! container.decode(String.self, forKey: .photo)
    }
}
