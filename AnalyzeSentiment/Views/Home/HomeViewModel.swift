//
//  HomeViewModel.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 21/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol HomeViewModelType {
    var titleController: String { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var errorMessage: PublishRelay<String?> { get }
    var searchUserText: BehaviorRelay<String> { get }
    var users: BehaviorRelay<[User]> { get }
    var userSelected: BehaviorRelay<User?> { get }
    var tweetsTableData: BehaviorRelay<[Tweet]> { get }
    
    func didTapSearch(text: String)
}

final class HomeViewModel: HomeViewModelType {
    
    // MARK: - Constants
    private let disposeBag = DisposeBag()
    let titleController = "home.title".localized
    private(set) var isLoading = BehaviorRelay<Bool>(value: false)
    private(set) var errorMessage = PublishRelay<String?>()
    private(set) var tweets = BehaviorRelay<[Tweet]>(value: [])
    private(set) var tweetsTableData = BehaviorRelay<[Tweet]>(value: [])
    private(set) var searchUserText = BehaviorRelay<String>(value: "")
    private(set) var users = BehaviorRelay<[User]>(value: [])
    private(set) var userSelected = BehaviorRelay<User?>(value: nil)
    
    // MARK: - Init
    init() {
        self.authenticate()
        
        // Should fetch users while user is typing
        searchUserText
            .subscribe(onNext: { [weak self] text in
                guard text.isEmpty == false else {
                    self?.users.accept([])
                    return
                }
                guard let self = self else { return }
                self.fetchUsers(nickname: text)
            })
            .disposed(by: disposeBag)
        
        // Fetch user's timeline when a user is selected
        userSelected
            .subscribe(onNext: { [weak self] userSelected in
                guard let user = userSelected else {
                    self?.errorMessage.accept("home.error.user_invalid".localized)
                    return
                }
                guard user.nickname != nil else {
                    self?.errorMessage.accept("home.error.user_without_nickname".localized)
                    return
                }
                self?.users.accept([])
                self?.fetchUserTimeline(user: user)
            })
            .disposed(by: disposeBag)
        
        // Analyze the sentiment of tweets after they're downloaded
        tweets
            .subscribe(onNext: { [weak self] tweets in
                guard tweets.count > 0 else { return }
                self?.analyzeTweetsSentiment(tweets)
            })
            .disposed(by: disposeBag)
    }
    
    func didTapSearch(text: String) {
        fetchUserInfo(nickname: text)
    }
}

// MARK: - Twitter
extension HomeViewModel {
    
    /// Autenthicates user if necessary
    private func authenticate(completion: (()->Void)? = nil) {
        
        guard SessionManager.isUserAuthenticated == false else {
            // don't need the authentication
            return
        }
        
        self.isLoading.accept(true)
        TwitterService
            .authenticate()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] response in
                    self?.isLoading.accept(false)
                    // Set user auth for next requests
                    SessionManager.setUserAuthorization(token: response.access_token)
                    completion?()
                }, onError: { [weak self] error in
                    self?.isLoading.accept(false)
                    self?.errorMessage.accept(error.requestMessage)
                }
            ).disposed(by: disposeBag)
    }
    
    /// Fetch the user info for specific nickname
    private func fetchUserInfo(nickname: String) {
        self.isLoading.accept(true)
        TwitterService
            .getUserInfo(nickname: nickname)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] user in
                    self?.isLoading.accept(false)
                    self?.userSelected.accept(user.asUser())
                }, onError: { [weak self] response in
                    self?.isLoading.accept(false)
                }
            ).disposed(by: disposeBag)
    }
    
    /// Fetch the user's tweets
    private func fetchUserTimeline(user: User) {
        guard let nick = user.nickname?.replacingOccurrences(of: "@", with: "") else { return }
        self.isLoading.accept(true)
        TwitterService
            .getUserTimeline(nickname: nick)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] response in
                    self?.isLoading.accept(false)
                    self?.tweets.accept(response.map({ $0.asTweet(user: user) }))
                },
                onError: { [weak self] error in
                    self?.isLoading.accept(false)
                    self?.errorMessage.accept(error.requestMessage)
                }
            ).disposed(by: disposeBag)
    }
    
    /// Simulate the `users/search` endpoint from twitter API (my key doesn't allow access it)
    private func fetchUsers(nickname: String) {
        self.isLoading.accept(true)
        TwitterService
            .getUsers()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] response in
                    self?.isLoading.accept(false)
                    self?.users.accept(
                        response
                            .users
                            .filter({ $0.screen_name?.localizedCaseInsensitiveContains(nickname) == true })
                            .map({ $0.asUser() })
                    )
                },
                onError: { [weak self] error in
                    self?.isLoading.accept(false)
                    self?.errorMessage.accept(error.requestMessage)
                }
            ).disposed(by: disposeBag)
    }

}

// MARK: - Google
extension HomeViewModel {
    
    /// Check the tweets sentiments using Google's Neural Language API
    private func analyzeTweetsSentiment(_ tweets: [Tweet]) {
        let sentences = tweets
                    .filter({ $0.text != nil })
                    .map({$0.text!.replacingOccurrences(of: "\n", with: "")})
                    .joined(separator: ".\n")
        
        guard sentences.count > 0 else { return }
        
        self.isLoading.accept(true)
        
        GoogleService
            .analyzeSentiment(tweets: sentences)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] response in
                    self?.isLoading.accept(false)
                    self?.tweetsTableData.accept(response.asTweetArray(user: tweets.first!.user ?? User()))
                },
                onError: { [weak self] error in
                    self?.isLoading.accept(false)
                    self?.errorMessage.accept(error.requestMessage)
                }
            ).disposed(by: disposeBag)
    }
}
