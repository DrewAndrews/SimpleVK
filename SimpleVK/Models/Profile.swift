//
//  Profile.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 29.08.2021.
//

import Foundation

struct Profile: Decodable {
    var id: Int
    var firstName: String
    var lastName: String
    var photos: [ProfilePhoto]?
    
    enum ProfileCodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photos
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: ProfileCodingKeys.self)
        id = try! container.decode(Int.self, forKey: .id)
        firstName = try! container.decode(String.self, forKey: .firstName)
        lastName = try! container.decode(String.self, forKey: .lastName)
        photos = try? container.decode([ProfilePhoto].self, forKey: .photos)
    }
}
