//
//  NetworkManager.swift
//  CardStore
//
//  Created by Sravya Chandrapati on 16/08/24.
// 

import Foundation
import Combine

protocol NetworkService {
    // Method to fetch cards from a remote URL
      func fetchCards() -> AnyPublisher<[Card], Error>
      
      // Method to load mock cards from a local JSON file
      func loadMockCards() -> AnyPublisher<[Card], Error>
}

class NetworkManager : NetworkService{
    
    static let shared = NetworkManager()
    
    private init() {}
    
    
    /// Fetches cards  from the specified remote URL
    func fetchCards() -> AnyPublisher<[Card], Error> {
        let url = URL(string: "https://random-data-api.com/api/v2/credit_cards?size=100")! // Replace with your API URL
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Card].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func loadMockCards() -> AnyPublisher<[Card], Error> {
        let url = Bundle.main.url(forResource: "CardResponseMockUp", withExtension: "json")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Card].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    

}
