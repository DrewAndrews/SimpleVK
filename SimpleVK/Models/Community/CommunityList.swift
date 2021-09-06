//
//  CommunityList.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 06.09.2021.
//

import Foundation

struct CommunityList: Decodable {
    var count: Int
    var items: [Community]
    
    private enum ResponseCodingKey: String, CodingKey {
        case response
    }
    
    private enum CommunityListCodingKey: CodingKey {
        case count
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: ResponseCodingKey.self)
        let communityContainer = try! container.nestedContainer(keyedBy: CommunityListCodingKey.self, forKey: .response)
        count = try! communityContainer.decode(Int.self, forKey: .count)
        items = try! communityContainer.decode([Community].self, forKey: .items)
    }
}
