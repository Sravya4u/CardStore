//
//  NetworkError.swift
//  CardStore
//
//  Created by Sravya Chandrapati on 18/08/24.
//

import Foundation

/// Enum representing various network-related errors.
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case timeout
    case cannotConnectToHost
    case fileNotFound
    case general(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .timeout:
            return "The request timed out."
        case .cannotConnectToHost:
            return "Cannot connect to the host."
        case .fileNotFound:
            return "The mock data file was not found."
        case .general(let message):
            return message
        }
    }
}










