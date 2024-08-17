//
//  NetworkManager.swift
//  CardStore
//
//  Created by Sravya Chandrapati on 16/08/24.
// 

import Foundation

protocol NetworkService {
    func fetchCards(from: URL, completion: @escaping (Result<Data, Error>) -> Void);
}

class NetworkManager : NetworkService{
    
    static let shared = NetworkManager()
    
    private init() {}
    
    /// Fetches data from the specified URL using a URLSession data task.
    ///
    /// - Parameters:
    ///   - url: The URL from which to fetch the data.
    ///   - completion: A closure to be executed upon completion of the data fetch operation, containing a result with either the fetched data or an error.
    func fetchCards(from: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        <#code#>
    }
    
    func loadMockCards(){}
    

}
