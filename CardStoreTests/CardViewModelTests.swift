//
//  CardViewModelTests.swift
//  CardStoreTests
//
//  Created by Sravya Chandrapati on 17/08/24.
//


import XCTest
import Combine
@testable import CardStore

class CardViewModelTests: XCTestCase {

    private var viewModel: CardViewModel!
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        viewModel = CardViewModel()
    }

    func testFetchCardsSuccess() {
        let expectation = XCTestExpectation(description: "Fetch cards successfully")
        
        viewModel.fetchCards()
        
        viewModel.$cards
            .sink { cards in
                if !cards.isEmpty {
                    XCTAssertEqual(cards.count, 100, "Should have 100 cards")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 15.0)
    }

    func testToggleBookmark() {
        let card = Card(id: 1, uid: "da5e2467-1557-49ad-bfee-89d2c7daaa16", creditCardNumber:"1228-1221-1221-1431", creditCardExpiryDate: "2026-08-15" ,creditCardType: "Visa", isBookmarked: false)
        viewModel.cards = [card]

        viewModel.toggleBookmark(card: card)

        XCTAssertTrue(viewModel.cards[0].isBookmarked, "Card should be bookmarked")

        viewModel.toggleBookmark(card: card)

        XCTAssertFalse(viewModel.cards[0].isBookmarked, "Card should be unbookmarked")
    }

    func testGroupedCards() {
        let card1 = Card(id: 1, uid: "da5e2467-1557-49ad-bfee-89d2c7daaa16", creditCardNumber:"1228-1221-1221-1431", creditCardExpiryDate: "2024-08-15" ,creditCardType: "Visa", isBookmarked: false)
        let card2 = Card(id: 2, uid: "da5e2467-1557-49ad-ttee-89d2c7daaa16", creditCardNumber:"1228-1221-1221-1432", creditCardExpiryDate: "2026-08-15" ,creditCardType: "Mastercard", isBookmarked: false)
        let card3 = Card(id: 3, uid: "da5e2467-1557-49ad-bfee-89d2c7daaa16", creditCardNumber:"1228-1221-1221-1433", creditCardExpiryDate: "2025-08-15" ,creditCardType: "Visa", isBookmarked: false)

        viewModel.cards = [card1, card2, card3]

        let groupedCards = viewModel.groupedCards()

        XCTAssertEqual(groupedCards["Visa"]?.count, 2, "There should be 2 Visa cards")
        XCTAssertEqual(groupedCards["Mastercard"]?.count, 1, "There should be 1 Mastercard")
    }
}



