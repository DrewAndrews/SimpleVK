//
//  Photo.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 29.08.2021.
//

import Foundation

struct Parameters: Decodable {
    var height: Int
    var url: String
    var width: Int
}

struct Photo: Decodable {
    var sizes: [Parameters]
}
