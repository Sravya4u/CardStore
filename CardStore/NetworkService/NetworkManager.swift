//
//  NetworkManager.swift
//  CardStore
//
//  Created by Sravya Chandrapati on 16/08/24.
//

import Combine
import Foundation


/**
 *  NetworkService.swift
 *
 *  Provides network services for fetching data from remote api.
 *  The NetworkService class conforms to the NetworkService protocol, defining methods for fetching data from a URL or load mock data and handling network-related errors.
 *
 *  - Author:  Sravya Chandrapati
 */
protocol NetworkService {
  // Method to fetch cards from a remote URL
  func fetchCards() -> AnyPublisher<[Card], Error>

  // Method to load mock cards from a local JSON file
  func loadMockCards() -> AnyPublisher<[Card], Error>
}

class NetworkManager: NetworkService {

  static let shared = NetworkManager()

  // MARK: - Private Initializer
  private init() {}

  // MARK: - Constants
  // Constants for fetch api and load mock data calls
  private enum URLConstants {
    static let baseURL = "https://random-data-api.com/api/v2/credit_cards?size=100"
    static let mockCardsURL = "CardResponseMockUp.json"
  }
}
// MARK: - Public Methods

extension NetworkManager {
  // Fetches cards  from the specified remote URL
  func fetchCards() -> AnyPublisher<[Card], Error> {
    guard let url = fetchCardsURL() else {
      return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
    }

    // Data task publisher handles decoding JSON data
    return createDataTaskPublisher(for: url)
      .tryMap { data in
        guard let response = try? JSONDecoder().decode([Card].self, from: data) else {
          throw DecodingError.decodingFailed
        }
        return response
      }
      .mapError { error in  // maps errors to be handled by type
        if error is URLError {
          return NetworkError.invalidURL
        } else if error is DecodingError {
          return DecodingError.decodingFailed
        } else {
          return NetworkError.general(error.localizedDescription)
        }
      }
      .eraseToAnyPublisher()
  }

  /// Load cards from mocked JSON response provided
  func loadMockCards() -> AnyPublisher<[Card], Error> {
    guard let url = mockCardsURL() else {
      return Fail(error: NetworkError.fileNotFound).eraseToAnyPublisher()
    }

    return createDataTaskPublisher(for: url)
      .decode(type: [Card].self, decoder: JSONDecoder())
      .mapError { error in
        // Map decoding error to a custom error
        (error as? DecodingError) ?? DecodingError.decodingFailed
      }
      .eraseToAnyPublisher()
  }

}

// MARK: - Private Methods
extension NetworkManager {

  // Construct the URL for fetching cards
  private func fetchCardsURL() -> URL? {
    return URL(string: URLConstants.baseURL)
  }

  // Construct the URL for loading mock cards
  private func mockCardsURL() -> URL? {
    return Bundle.main.url(forResource: URLConstants.mockCardsURL, withExtension: nil)
  }

  private func createDataTaskPublisher(for url: URL) -> AnyPublisher<Data, URLError> {
    return URLSession.shared.dataTaskPublisher(for: url)
      .map(\.data)
      .eraseToAnyPublisher()
  }

  // Map URLErrors to a custom NetworkError
  private func mapURLError(_ error: URLError) -> NetworkError {
    switch error.code {
    case .timedOut:
      return NetworkError.timeout
    case .cannotConnectToHost:
      return NetworkError.cannotConnectToHost
    default:
      return NetworkError.general(error.localizedDescription)
    }

  }
}
