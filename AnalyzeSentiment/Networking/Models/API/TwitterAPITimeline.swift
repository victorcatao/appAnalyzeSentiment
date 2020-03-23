//
//  TwitterTimeline.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 21/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import Foundation

struct TwitterAPITimeline: Codable {
    var text: String?
    var retweet_count: Int?
    var favorite_count: Int?
    
    func asTweet(user: User) -> Tweet {
        return Tweet(text: text, user: user, reactionEmoji: nil)
    }
    
}
