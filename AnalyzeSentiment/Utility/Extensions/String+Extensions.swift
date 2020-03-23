//
//  String+Extensions.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 21/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import UIKit

// MARK: - Variables
extension String {

    /// Returns the current String localized
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// Returns the base64 for string
    var base64EncodedString: String? {
        let data = (self as NSString).data(using: String.Encoding.utf8.rawValue)
        return data?.base64EncodedString()
    }
    
    /// Returns the intValue for this string
    var intValue: Int? {
        return Int(self)
    }

}
