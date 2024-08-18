//
//  CardViewModelTests.swift
//  CardStoreTests
//
//  Created by Sravya on 17/08/24.
//

import XCTest
import Combine
@testable import CardStore

class CardViewModelTests: XCTestCase {
    var viewModel: CardViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        viewModel = CardViewModel(useMockData: false)
    }
    
    override func tearDown() {
        cancellables = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchCardsSuccess() {
        let expectation = XCTestExpectation(description: "Fetch cards from API")
        
        viewModel.fetchCards()
        viewModel.$cards
            .receive(on: DispatchQueue.main)
            .sink { cards in
                if !cards.isEmpty {
                    XCTAssertEqual(cards.count, 100, "Should have 100 cards")
                    print("Count is  --- \(cards.count)")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 30.0)
    }
    
//    func testLoadMockCardsSuccess() {
//        let expectation = XCTestExpectation(description: "Load mock cards from local JSON file")
//
//        viewModel.loadMockCards()
//        viewModel.$cards
//            .sink { cards in
//                if !cards.isEmpty {
//                    XCTAssertEqual(cards.count, 10, "Should have 10 mock cards")
//                    expectation.fulfill()
//                }
//            }
//            .store(in: &cancellables)
//
//        wait(for: [expectation], timeout: 5.0)
//    }
//
//    func testFetchCardsFailure() {
//        let expectation = XCTestExpectation(description: "Fetch cards should fail with incorrect URL")
//        let invalidViewModel = CardViewModel(networkService: MockNetworkServiceFailure(),useMockData: false)
//
//        invalidViewModel.fetchCards()
//
//        invalidViewModel.$errorMessage
//            .sink { errorMessage in
//                if let errorMessage = errorMessage {
//                    XCTAssertNotNil(errorMessage, "Expected error message to be non-nil")
//                    expectation.fulfill()
//                }
//            }
//            .store(in: &cancellables)
//
//        wait(for: [expectation], timeout: 5.0)
//    }
//}
//
//
//class MockNetworkServiceFailure: NetworkService {
//    func fetchCards() -> AnyPublisher<[Card], Error> {
//        return Fail(error: URLError(.badServerResponse))
//            .eraseToAnyPublisher()
//    }
//
//    func loadMockCards() -> AnyPublisher<[Card], Error> {
//        return Fail(error: URLError(.badServerResponse))
//            .eraseToAnyPublisher()
//    }
}
