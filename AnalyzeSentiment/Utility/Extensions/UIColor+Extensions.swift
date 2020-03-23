//
//  UIColor+Extensions.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 21/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import UIKit
import Foundation


extension UIColor{
    
    /// Returns a given AssetsColor
    static func appColor(_ name: AppSettings.AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
    
}
