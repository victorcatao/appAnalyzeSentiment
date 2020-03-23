//
//  TweetTableViewCell.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 21/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import UIKit

final class TweetTableViewCell: UITableViewCell {
    
    // MARK: - Views
    private lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Layout.userImageSize, height: Layout.userImageSize))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Layout.userImageSize/2
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.appColor(.textColor)
        label.font = UIFont.mediumSemibold
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var userTweetLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.appColor(.subtitleTextColor)
        label.font = UIFont.default
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var sentimentLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appColor(.separatorColor)
        return view
    }()
    
    // MARK: - Layout Settings
    enum Layout {
        static let userImageSize: CGFloat = 30
        static let separatorHeight: CGFloat = 1
        static let sentimentLabelWidth: CGFloat = 25
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
    private func setupView() {
        selectionStyle = .none
        [
            userPhotoImageView,
            userNameLabel,
            userTweetLabel,
            sentimentLabel,
            separatorView
        ].forEach({ contentView.addSubview($0) })
        
        userPhotoImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(AppSettings.Layout.mediumSpacing)
            make.height.width.equalTo(Layout.userImageSize)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(AppSettings.Layout.mediumSpacing)
            make.leading.equalTo(userPhotoImageView.snp.trailing).offset(AppSettings.Layout.mediumSpacing)
            make.trailing.equalTo(sentimentLabel.snp.leading)
        }
        
        userTweetLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom)
            make.leading.equalTo(userNameLabel.snp.leading)
            make.trailing.equalTo(userNameLabel.snp.trailing)
            make.bottom.equalToSuperview().inset(AppSettings.Layout.mediumSpacing)
        }
        
        sentimentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(Layout.sentimentLabelWidth)
            make.trailing.equalToSuperview().inset(AppSettings.Layout.mediumSpacing)
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(AppSettings.Layout.defaultSpacing)
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(AppSettings.Layout.defaultSpacing)
            make.height.equalTo(Layout.separatorHeight)
        }
    }
    
    func setup(tweet: Tweet) {
        userPhotoImageView.setImage(imageURL: tweet.user?.photo)
        userNameLabel.text = tweet.user?.name
        userTweetLabel.text = tweet.text
        sentimentLabel.text = tweet.reactionEmoji
    }
    
}
