//
//  UIImageView+Extensions.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 21/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    /// Loads a given url image, if the url is nil, loads the default image "placeHolderNoPhoto"
    func setImage(imageURL: String?){
        if let imgURL = imageURL {
            UIView.animate(withDuration: 0.5) {
                self.sd_setImage(with: URL(string: imgURL), completed: nil)
            }
        }
    }
    
}
