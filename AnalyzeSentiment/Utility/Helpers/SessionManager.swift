//
//  UserManager.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 22/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import Foundation

class SessionManager {
    
    // MARK: - Authorization
    static var twitterAuthorization: String? {
        return UserDefaults.standard.string(forKey: AppSettings.Keys.twitterBearerAuthorization)
    }
    
    static var isUserAuthenticated: Bool {
        return twitterAuthorization != nil
    }
    
    static func setUserAuthorization(token: String?) {
        UserDefaults.standard.set(token, forKey: AppSettings.Keys.twitterBearerAuthorization)
    }
    
    static func deleteUserAuthorization() {
        UserDefaults.standard.set(nil, forKey: AppSettings.Keys.twitterBearerAuthorization)
    }
}
