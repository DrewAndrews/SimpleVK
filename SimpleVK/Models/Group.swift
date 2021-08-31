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
    var photos: [ProfilePhoto]?
}
