//
//  Attachment.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 29.08.2021.
//

import Foundation

struct Attachment: Decodable {
    var type: String
    var photo: Photo?
}
