//
//  UIViewController+Extensions.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 21/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import UIKit

private var loaderView: UIView?

extension UIViewController {
    
    /// Shows an alert with custom title, message and actions
    func showErrorAlert(message: String) {
        self.showAlert(title: "error".localized, message: message)
    }
    
    func showAlert(title: String, message: String, okBlock:(() -> Void)?=nil, cancelBlock: (() -> Void)?=nil){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        var titleOkAction     = "ok".localized
        var titleCancelAction = "cancel".localized
        
        if (cancelBlock != nil) {
            titleOkAction     = "yes".localized
            titleCancelAction = "no".localized
        }
        
        let ok = UIAlertAction(title: titleOkAction, style: .default) { (action) in
            if let okBl = okBlock {
                okBl()
            }
            alert.dismiss(animated: true, completion: nil);
        }
        alert.addAction(ok)
        
        if let cancelBl = cancelBlock {
            let cancel = UIAlertAction(title: titleCancelAction, style: .cancel) { (action) in
                cancelBl()
            }
            alert.addAction(cancel)
        }
        self.present(alert, animated: true, completion: nil)
    }

    /// Shows a loading view over the current ViewController
    func showLoader() {
        
        if(loaderView == nil) {
            // creating loaderView
            loaderView = UIView(frame: UIScreen.main.bounds)
            loaderView!.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            
            // white view in center
            let centerView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            centerView.backgroundColor = .white
            centerView.layer.cornerRadius = 4
            centerView.alpha = 0.5
            
            loaderView!.addSubview(centerView)
            centerView.center = loaderView!.center
            
            // stackview for loader and text
            let stackView = UIStackView(frame: centerView.frame)
            stackView.spacing = 8
            stackView.axis = .vertical
            
            // loader
            let loader = UIActivityIndicatorView(style: .medium)
            loader.startAnimating()
            loader.color = UIColor.appColor(.primaryColor)
            stackView.addArrangedSubview(loader)
            
            // add stackview as subview for centerView
            centerView.addSubview(stackView)
            
            // setup constraints
            stackView.translatesAutoresizingMaskIntoConstraints = false
            centerView.addConstraints([
                NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: centerView, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: stackView, attribute: .centerY, relatedBy: .equal, toItem: centerView, attribute: .centerY, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: centerView, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: centerView, attribute: .trailing, multiplier: 1, constant: 0)
            ])
            
        }
        
        if self.navigationController ==  nil {
            self.view.addSubview(loaderView!)
        } else {
            self.navigationController?.view.addSubview(loaderView!)
        }
        
    }
    
    /// Hides the loading view which is over the current ViewController
    func hideLoader() {
        if(loaderView != nil){
            loaderView?.removeFromSuperview()
        }
    }
    
}
