//
//  GoogleService.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 22/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class GoogleService {
    
    static func analyzeSentiment(tweets: String) -> Observable<GoogleAPIAnalyzeSentiment> {
        var parameters = Parameters()
        parameters["encodingType"] = "UTF8"
        
        var document = Parameters()
        document["type"] = "PLAIN_TEXT"
        document["content"] = tweets
        
        parameters["document"] = document
        
        return RequestManager.postToAPIService(
            baseURL: Endpoint.Google.baseURL,
            endpoint: Endpoint.Google.analyzeSentiment,
            parameters: parameters
        )
    }

    
}
