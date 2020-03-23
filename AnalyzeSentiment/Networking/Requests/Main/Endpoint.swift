//
//  Endpoint.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 21/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

// Enum of the endpoints used by the app.
// All the endpoints used in the requests must be added here
enum Endpoint {

    enum Google {
        static let baseURL          = "https://language.googleapis.com/v1/"
        static let analyzeSentiment = "documents:analyzeSentiment?key=\(AppSettings.Keys.googleKey)"
    }
    
    enum Twitter: String {
        case baseURL        = "https://api.twitter.com/"
        case authentication = "oauth2/token"
        case userTimeline   = "1.1/statuses/user_timeline.json"
        case userInfo       = "1.1/users/show.json"
        case followers      = "1.1/followers/list.json"
    }
    
}
