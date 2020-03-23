//
//  TwitterService.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 21/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class TwitterService {
    
    private static var headers = {
        return ["Authorization": "Bearer \(SessionManager.twitterAuthorization ?? "")"]
    }()
    
    static func authenticate() -> Observable<TwitterAPIToken> {
        
        let credential = "\(AppSettings.Keys.twitterConsumerKey):\(AppSettings.Keys.twitterConsumerSecret)"
        let base64String = credential.base64EncodedString ?? ""
        let headers = ["Authorization": "Basic \(base64String)", "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"]
        
        var params = Parameters()
        params["grant_type"] = "client_credentials"
        
        return RequestManager.postToAPIService(
            baseURL: Endpoint.Twitter.baseURL.rawValue,
            endpoint: Endpoint.Twitter.authentication.rawValue,
            headers: headers,
            parameters: params,
            encoding: URLEncoding.default
        )
    }
    
    static func getUserTimeline(nickname: String) -> Observable<[TwitterAPITimeline]> {
        var parameters = Parameters()
        parameters["screen_name"] = nickname
        
        return RequestManager.getToAPIService(
            baseURL: Endpoint.Twitter.baseURL.rawValue,
            endpoint: Endpoint.Twitter.userTimeline.rawValue,
            headers: headers,
            parameters: parameters
        )
    }
    
    static func getUsers() -> Observable<TwitterAPIFollowers> {
        var params = Parameters()
        params["screen_name"] = "zecapagodinho"
        
        return RequestManager.getToAPIService(
            baseURL: Endpoint.Twitter.baseURL.rawValue,
            endpoint: Endpoint.Twitter.followers.rawValue,
            headers: headers,
            parameters: params
        )
    }
    
    static func getUserInfo(nickname: String) -> Observable<TwitterAPIUser> {
        var parameters = Parameters()
        parameters["screen_name"] = nickname
        
        return RequestManager.getToAPIService(
            baseURL: Endpoint.Twitter.baseURL.rawValue,
            endpoint: Endpoint.Twitter.userInfo.rawValue,
            headers: headers,
            parameters: parameters
        )
    }
    
}
