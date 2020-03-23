//
//  Tweet.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 21/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import Foundation

enum EmojiReaction: String {
    case sad     = "☹️"
    case neutral = "🤔"
    case happy   = "😄"
    case invalid = "🤷‍♂️"
}

struct Tweet: Codable {
    var text: String?
    var user: User?
    var reactionEmoji: String?
}
