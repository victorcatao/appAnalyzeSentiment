//
//  ViewCodeProtocol.swift
//  Project
//
//  Created by Victor Catão on 01/03/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import UIKit

class ViewCodeProtocol<ContainerViewType: UIView>: UIViewController {
    
    var containerView = ContainerViewType()
    
    override func loadView() {
        view = containerView
    }
}
