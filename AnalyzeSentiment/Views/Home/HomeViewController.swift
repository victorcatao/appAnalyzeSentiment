//
//  HomeViewController.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 21/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import UIKit
import RxSwift

final class HomeViewController: ViewCodeProtocol<HomeView> {
    
    // MARK: - Init
    init(viewModel: HomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Variables and Constants
    private(set) var viewModel: HomeViewModelType!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableViews()
        setupSubscribers()
    }
    
    // MARK: - Setup
    private func setupView() {
        title = viewModel.titleController
    }
    
    private func setupTableViews() {
        viewModel
            .tweetsTableData
            .asDriver()
            .drive(containerView.tableView.rx.items(cellIdentifier: String(describing: TweetTableViewCell.self), cellType: TweetTableViewCell.self)) { _, element, cell in
               UIView.animate(withDuration: 0.3) {
                   cell.setup(tweet: element)
               }
            }.disposed(by: disposeBag)
        
        viewModel
            .users
            .asDriver()
            .drive(containerView.autocompleteTableView.rx.items(cellIdentifier: String(describing: UserTableViewCell.self), cellType: UserTableViewCell.self)){ row, element, cell in
                cell.setup(user: element)
            }.disposed(by: disposeBag)
        
        containerView
            .autocompleteTableView
            .rx
            .modelSelected(User.self)
            .asDriver()
            .drive(onNext: { [weak self] user in
                self?.view.endEditing(true)
                self?.containerView.searchBar.searchTextField.text = user.nickname
                self?.viewModel.userSelected.accept(user)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .users
            .asDriver()
            .map({
                CGFloat($0.count) * HomeView.Layout.heightAutocompleteCell > HomeView.Layout.maxHeightTableView ?
                    HomeView.Layout.maxHeightTableView : CGFloat($0.count) * HomeView.Layout.heightAutocompleteCell
            })
            .drive(onNext: { [weak self] height in
                self?.containerView.blurView.isHidden = height == 0
                self?.containerView.updateAutocompleteTableViewHeight(height)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupSubscribers() {
        
        // Listening to changes on searchBar's textField
        containerView
            .searchBar
            .rx
            .text
            .orEmpty
            .asDriver()
            .debounce(.milliseconds(200))
            .distinctUntilChanged()
            .drive(onNext: { [weak self] value in
                self?.viewModel.searchUserText.accept(value)
            })
            .disposed(by: disposeBag)
        
        // Listening to tap on "Search" button
        containerView
            .searchButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.userDidTapSearch()
            })
            .disposed(by: disposeBag)
        
        // Listening to tap on keyboard "Search" button
        containerView
            .searchBar
            .searchTextField
            .rx
            .controlEvent(.editingDidEndOnExit)
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.userDidTapSearch()
            })
            .disposed(by: disposeBag)
        
        // Hanlde loader
        viewModel
            .isLoading
            .asDriver()
            .drive(onNext: { [weak self] isLoading in
                isLoading ? self?.showLoader() : self?.hideLoader()
            })
            .disposed(by: disposeBag)
        
        // Show error message
        viewModel
            .errorMessage
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] text in
                guard let message = text else { return }
                self?.showErrorAlert(message: message)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    private func userDidTapSearch() {
        guard let searchText = self.containerView.searchBar.text else { return }
        self.view.endEditing(true)
        self.viewModel.didTapSearch(text: searchText)
    }
    
}
