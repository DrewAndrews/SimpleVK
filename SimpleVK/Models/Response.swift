//
//  Response.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 29.08.2021.
//

import Foundation

struct Response: Decodable {
    var items: [Post]
    var profiles: [Profile]
    var groups: [Group]
    
    enum AllInformationCodingKeys: CodingKey {
        case items
        case profiles
        case groups
    }
    
    enum ResponseKey: CodingKey {
        case response
    }
    
    init(from decoder: Decoder) throws {
        let responseContainer = try! decoder.container(keyedBy: ResponseKey.self)
        let allInformationContainer = try! responseContainer.nestedContainer(keyedBy: AllInformationCodingKeys.self, forKey: .response)
        items = try! allInformationContainer.decode([Post].self, forKey: .items)
        profiles = try! allInformationContainer.decode([Profile].self, forKey: .profiles)
        groups = try! allInformationContainer.decode([Group].self, forKey: .groups)
    }
}
