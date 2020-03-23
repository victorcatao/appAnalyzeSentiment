//
//  TwitterAPIFollowers.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 22/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import Foundation

struct TwitterAPIFollowers: Codable {
    var users: [TwitterAPIUser]
}

struct TwitterAPIUser: Codable {
    var name: String?
    var screen_name: String?
    var profile_image_url_https: String?
    
    func asUser() -> User {
        return User(nickname: screen_name, name: name, photo: profile_image_url_https)
    }
    
}
