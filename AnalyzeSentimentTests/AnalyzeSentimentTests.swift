//
//  AnalyzeSentimentTests.swift
//  AnalyzeSentimentTests
//
//  Created by Victor Catão on 21/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import AnalyzeSentiment

class AnalyzeSentimentTests: QuickSpec {
    
    override func spec() {
        var subject: HomeViewController!
        
        describe("HomeViewControllerSpec") {
            beforeEach {
                subject = HomeViewController(viewModel: HomeViewModel())
                _ = subject.view
            }
            
            context("when view is loaded") {
                it("should have zero rows") {
                    expect(subject.containerView.tableView.numberOfRows(inSection: 0)).to(equal(0))
                    expect(subject.containerView.autocompleteTableView.numberOfRows(inSection: 0)).to(equal(0))
                }
            }
            
            context("when search for neymarjr") {
                it("should have a lot of rows") {
                    subject.containerView.searchBar.searchTextField.text = "neymarjr"
                    subject.containerView.searchButton.sendActions(for: .touchUpInside)
                    expect(
                        subject
                            .containerView
                            .tableView
                            .numberOfRows(inSection: 0)
                    ).toEventuallyNot(equal(0), timeout: TimeInterval(10), pollInterval: TimeInterval(1), description: nil)
                }
            }
            
            context("when test sentiment conversion") {
                it("should be sad") {
                    let sad1 = GoogleAPISentiment(score: -1)
                    let sad2 = GoogleAPISentiment(score: -0.8)
                    let sad3 = GoogleAPISentiment(score: -0.7)
                    
                    expect(sad1.getEmojiForSentiment()).to(equal(EmojiReaction.sad))
                    expect(sad2.getEmojiForSentiment()).to(equal(EmojiReaction.sad))
                    expect(sad3.getEmojiForSentiment()).to(equal(EmojiReaction.sad))
                }
                
                it("should be neutral") {
                    let neutral1 = GoogleAPISentiment(score: 0)
                    let neutral2 = GoogleAPISentiment(score: -0.2)
                    let neutral3 = GoogleAPISentiment(score: 0.23)
                    
                    expect(neutral1.getEmojiForSentiment()).to(equal(EmojiReaction.neutral))
                    expect(neutral2.getEmojiForSentiment()).to(equal(EmojiReaction.neutral))
                    expect(neutral3.getEmojiForSentiment()).to(equal(EmojiReaction.neutral))
                }
                
                it("should be happy") {
                    let happy1 = GoogleAPISentiment(score: 1)
                    let happy2 = GoogleAPISentiment(score: 0.9)
                    let happy3 = GoogleAPISentiment(score: 0.4)
                    
                    expect(happy1.getEmojiForSentiment()).to(equal(EmojiReaction.happy))
                    expect(happy2.getEmojiForSentiment()).to(equal(EmojiReaction.happy))
                    expect(happy3.getEmojiForSentiment()).to(equal(EmojiReaction.happy))
                }
                
                it("should be invalid") {
                    let invalid1 = GoogleAPISentiment(score: 1.2)
                    let invalid2 = GoogleAPISentiment(score: -1.3)
                    let invalid3 = GoogleAPISentiment(score: 20)
                    
                    expect(invalid1.getEmojiForSentiment()).to(equal(EmojiReaction.invalid))
                    expect(invalid2.getEmojiForSentiment()).to(equal(EmojiReaction.invalid))
                    expect(invalid3.getEmojiForSentiment()).to(equal(EmojiReaction.invalid))
                }
                
            }
            
        }
    }

}
