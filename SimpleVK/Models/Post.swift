//
//  Post.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 28.08.2021.
//

import Foundation

/* отображение постов ленты новостей пользователя
 (аватар автора/сообщества,
 полное имя,
 дата и время публиĸации,
 теĸст поста не более 5ти строĸ,
 минимум одно изображение приĸрепленное ĸ посту если есть + счетчиĸ общего ĸоличества изображений в посте). */

struct Post: Decodable {
    var sourceId: Int
    var postTime: Int
    var text: String
    var attachments: [Attachment]?
    
    enum PostCodingKeys: String, CodingKey {
        case postTime = "date"
        case text
        case sourceId = "source_id"
        case attachments
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: PostCodingKeys.self)
        postTime = try! container.decode(Int.self, forKey: .postTime)
        text = try! container.decode(String.self, forKey: .text)
        sourceId = abs(try! container.decode(Int.self, forKey: .sourceId))
        attachments = try? container.decode([Attachment].self, forKey: .attachments)
    }
}
