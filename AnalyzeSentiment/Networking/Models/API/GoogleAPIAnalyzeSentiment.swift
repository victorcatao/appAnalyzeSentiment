//
//  GoogleAPISentiment.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 22/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import Foundation

struct GoogleAPIAnalyzeSentiment: Codable {
    var sentences: [GoogleAPISentence]?
    
    func asTweetArray(user: User) -> [Tweet] {
        guard let sentences = sentences else { return [] }
        return sentences.map({$0.asTweet(user: user)})
    }
}

struct GoogleAPISentence: Codable {
    var text: GoogleAPIText?
    var sentiment: GoogleAPISentiment?
    
    func asTweet(user: User) -> Tweet {
        return Tweet(
            text: text?.content,
            user: user,
            reactionEmoji: sentiment?.getEmojiForSentiment().rawValue
        )
    }
}

struct GoogleAPIText: Codable {
    var content: String?
}

struct GoogleAPISentiment: Codable {
    var score: Float?
    
    /// Get emoji for score.
    /// The score works between -1 and 1 (https://cloud.google.com/natural-language/docs/reference/rest/v1/Sentiment)
    ///      sad                     neutral                happy
    ///  |----------------------|----------------------|----------------------|
    /// -1                       -1+2/3                  1-2/3                     1
    func getEmojiForSentiment() -> EmojiReaction {
        guard let score = score else {
            return .invalid
        }
        
        let firstSegment: Float = -1.0
        let secondSegment: Float = -1.0 + 2.0/3.0
        let thirdSegment: Float = 1 - 2.0/3.0
        let limitSegment: Float = 1

        switch score {
        case firstSegment...secondSegment:
            return .sad
        case secondSegment...thirdSegment:
            return .neutral
        case thirdSegment...limitSegment:
            return .happy
        default:
            return .invalid
        }
        
    }
    
}
