//
//  HomeView.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 21/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import UIKit
import SnapKit

class HomeView: UIView {
    
    // MARK: - Views
    private lazy var searchView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.appColor(.backgroundColor)
        v.addSubview(searchBar)
        v.addSubview(searchButton)
        v.layer.borderColor = UIColor.appColor(.separatorColor)?.cgColor
        v.layer.borderWidth = 1
        v.clipsToBounds = true
        return v
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.autocapitalizationType = .none
        searchBar.placeholder = "home.searchBar.placeholder".localized
        return searchBar
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.appColor(.primaryColor)
        button.layer.cornerRadius = 4
        button.setTitle("home.searchBar.buttonTitle".localized, for: .normal)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var autocompleteTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.8
        return blurEffectView
    }()
    
    
    // MARK: - Layout constants
    struct Layout {
        static let searchViewHeight: CGFloat       = 50
        static let searchButtonHeight: CGFloat     = 35
        static let searchButtonWidth: CGFloat      = 100
        static let heightAutocompleteCell: CGFloat = 50
        static let maxHeightTableView: CGFloat     = 4 * heightAutocompleteCell
    }
    
    private var autocompleteTableViewHeightConstraint: ConstraintMakerEditable?
    
    // MARK: - LifeCycle
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addSubviews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.appColor(.backgroundColor)
    }
    
    private func addSubviews() {
        [searchView, tableView, blurView, autocompleteTableView].forEach({ super.addSubview($0) })
    }
    
    // MARK: - Setup
    private func setupConstraints() {
        searchView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Layout.searchViewHeight)
        }
        
        searchBar.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.trailing.equalTo(searchButton.snp.leading)
        }
        
        searchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(AppSettings.Layout.defaultSpacing)
            make.leading.equalTo(searchButton.snp.trailing)
            make.centerY.equalToSuperview()
            make.height.equalTo(Layout.searchButtonHeight)
            make.width.equalTo(Layout.searchButtonWidth)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        blurView.snp.makeConstraints { make in
            make.edges.equalTo(tableView)
        }
        
        autocompleteTableView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            autocompleteTableViewHeightConstraint = make.height.equalTo(0) //starts with 0
        }
        
        autocompleteTableView.register(UserTableViewCell.self, forCellReuseIdentifier: String(describing: UserTableViewCell.self))
        autocompleteTableView.rowHeight = Layout.heightAutocompleteCell
        
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: String(describing: TweetTableViewCell.self))
    }
    
    func updateAutocompleteTableViewHeight(_ height: CGFloat) {
        guard let constraint = autocompleteTableViewHeightConstraint else { return }
        UIView.animate(withDuration: 0.3) {
            constraint.constraint.layoutConstraints.first?.constant = height
            super.layoutIfNeeded()
        }
    }
    
}
