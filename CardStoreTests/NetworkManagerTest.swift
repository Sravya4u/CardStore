//
//  NetworkManagerTest.swift
//  CardStoreTests
//
//  Created by Sravya Chandrapati on 17/08/24.
//
import XCTest
import Combine
@testable import CardStore

class NetworkManagerTests: XCTestCase {

    var cancellables: Set<AnyCancellable>!
    var networkManager: NetworkManager!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        networkManager = NetworkManager.shared
    }
    
    override func tearDown() {
        cancellables = nil
        networkManager = nil
        super.tearDown()
    }
    
    func testFetchCardsSuccess() {
          let expectation = XCTestExpectation(description: "Fetch cards from API")
          
          networkManager.fetchCards()
              .sink(receiveCompletion: { completion in
                  if case .failure(let error) = completion {
                      XCTFail("Fetch failed: \(error.localizedDescription)")
                  }
              }, receiveValue: { cards in
                  XCTAssertFalse(cards.isEmpty, "Cards should not be empty")
                  XCTAssertEqual(cards.count, 10, "Should have 10 cards")
              })
              .store(in: &cancellables)
          
          wait(for: [expectation], timeout: 5.0)
      }

    // Test case for loadMockCards() success
    func testLoadMockCardsSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Mock cards are loaded successfully")
        var loadedCards: [Card]?

        // When
        networkManager.loadMockCards()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Loading mock cards failed with error: \(error)")
                }
            }, receiveValue: { cards in
                loadedCards = cards
                expectation.fulfill()
            }).store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(loadedCards, "No mock cards were loaded.")
        XCTAssertTrue(loadedCards?.count ?? 0 > 0, "Mock cards list is empty.")
       
    }
    
   
    }
    
