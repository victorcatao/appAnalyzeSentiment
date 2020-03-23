//
//  APPConstants.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 21/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import UIKit

//enum Constants {
//    static let noResultsImage: String = "no-results-icon"
//    static let placeHolderNoPhoto: String = "placeholder-no-photo"
//}

enum AppSettings {
    
    enum AssetsColor: String {
        case backgroundColor
        case subtitleTextColor
        case textColor
        case primaryColor
        case separatorColor
    }
    
    enum Layout {
        static let smallSpacing: Int   = defaultSpacing / 2
        static let defaultSpacing: Int = 8
        static let mediumSpacing: Int  = defaultSpacing * 2
        static let bigSpacing: Int     = defaultSpacing * 3
    }
    
    enum Keys {
        static let twitterBearerAuthorization = "twitterBearerAuthorization"
        static let googleKey = "AIzaSyBKjnvh-PIAhmoIYYiAdEqj2irAYnFL-ic"
        static let twitterConsumerKey = "8z78TYLEVElCOtQwWlt5yc9Fa"
        static let twitterConsumerSecret = "XbbIyEU9d1Gkj57JbSYCLVnYwT8yPEbqy7ztN0EP1qM91rQnP8"
    }
    
}

extension UIFont {
    // Default
    static let xsmall = UIFont.systemFont(ofSize: 10)
    static let small  = UIFont.systemFont(ofSize: 12)
    static let `default` = UIFont.systemFont(ofSize: 14)
    static let medium = UIFont.systemFont(ofSize: 16)
    static let big    = UIFont.systemFont(ofSize: 18)
    static let xbig   = UIFont.systemFont(ofSize: 20)
    
    // Medium
    static let xsmallMedium = UIFont.systemFont(ofSize: 10, weight: .medium)
    static let smallMedium  = UIFont.systemFont(ofSize: 12, weight: .medium)
    static let defaultMedium = UIFont.systemFont(ofSize: 14, weight: .medium)
    static let mediumMedium = UIFont.systemFont(ofSize: 16, weight: .medium)
    static let bigMedium    = UIFont.systemFont(ofSize: 18, weight: .medium)
    static let xbigMedium   = UIFont.systemFont(ofSize: 20, weight: .medium)
    
    // Semibold
    static let xsmallSemibold = UIFont.systemFont(ofSize: 10, weight: .semibold)
    static let smallSemibold  = UIFont.systemFont(ofSize: 12, weight: .semibold)
    static let defaultSemibold = UIFont.systemFont(ofSize: 14, weight: .semibold)
    static let mediumSemibold = UIFont.systemFont(ofSize: 16, weight: .semibold)
    static let bigSemibold    = UIFont.systemFont(ofSize: 18, weight: .semibold)
    static let xbigSemibold   = UIFont.systemFont(ofSize: 20, weight: .semibold)
    
    // Bold
    static let xsmallBold = UIFont.systemFont(ofSize: 10, weight: .bold)
    static let smallBold  = UIFont.systemFont(ofSize: 12, weight: .bold)
    static let defaultBold = UIFont.systemFont(ofSize: 14, weight: .bold)
    static let mediumBold = UIFont.systemFont(ofSize: 16, weight: .bold)
    static let bigBold    = UIFont.systemFont(ofSize: 18, weight: .bold)
    static let xbigBold   = UIFont.systemFont(ofSize: 20, weight: .bold)
}

