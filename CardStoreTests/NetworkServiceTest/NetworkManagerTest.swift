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

    var networkManager: NetworkManager!

    override func setUpWithError() throws {
        // Initialize before each test
        networkManager = NetworkManager.shared
    }

    override func tearDownWithError() throws {
        // Clean up after each test
        networkManager = nil
    }

    // Test case for loadMockCards() success
    func testLoadMockCardsSuccess() {
        // Given

        // When

        // Then
       
    }
    
}
