//
//  UserTableViewCell.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 22/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    
    // MARK: - Views
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.appColor(.textColor)
        label.font = UIFont.smallMedium
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Layout.userImageSize, height: Layout.userImageSize))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Layout.userImageSize/2
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // MARK: - Layout Settings
    enum Layout {
        static let userImageSize: CGFloat = 30
    }
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    // MARK: - Setups
    func setup(user: User) {
        nicknameLabel.text = user.nickname
        userImageView.setImage(imageURL: user.photo)
    }
    
    private func setupView() {
        selectionStyle = .none
        // Adding to view's to contetView
        [nicknameLabel, userImageView].forEach({ contentView.addSubview($0) })
        
        // Constraints
        userImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(AppSettings.Layout.mediumSpacing)
            make.trailing.equalTo(nicknameLabel.snp.leading).offset(-AppSettings.Layout.smallSpacing)
            make.height.width.equalTo(Layout.userImageSize)
            make.centerY.equalToSuperview()
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(AppSettings.Layout.bigSpacing)
            make.centerY.equalToSuperview()
        }
    }
    
}

