//
//  DecodingError.swift
//  CardStore
//
//  Created by Sravya Chandrapati on 18/08/24.
//

import Foundation

/// Enum representing various JSON decoding errors on API calls
enum DecodingError: Error, LocalizedError {
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .decodingFailed:
            return "Failed to decode the response."
        }
    }
}
