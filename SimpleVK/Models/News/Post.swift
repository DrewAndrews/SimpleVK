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
    var views: Int
    var reposts: Int
    var attachments: [Attachment]?
    
    enum PostCodingKeys: String, CodingKey {
        case postTime = "date"
        case text
        case sourceId = "source_id"
        case views
        case reposts
        case attachments
    }
    
    private struct Views: Decodable {
        var count: Int
    }
    
    private struct Reposts: Decodable {
        var count: Int
    }
    
    init() {
        sourceId = 0
        postTime = 0
        text = ""
        views = 0
        reposts = 0
        attachments = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: PostCodingKeys.self)
        postTime = try! container.decode(Int.self, forKey: .postTime)
        text = try! container.decode(String.self, forKey: .text)
        sourceId = abs(try! container.decode(Int.self, forKey: .sourceId))
        attachments = try? container.decode([Attachment].self, forKey: .attachments)
        let viewsInContainer = try! container.decode(Views.self, forKey: .views)
        views = viewsInContainer.count
        let repostsInContainer = try! container.decode(Reposts.self, forKey: .reposts)
        reposts = repostsInContainer.count
    }
}
