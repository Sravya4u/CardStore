//
//  DecodingError.swift
//  CardStore
//
//  Created by Sravya Chandrapati on 18/08/24.
//

import Foundation

enum DecodingError: Error, LocalizedError {
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .decodingFailed:
            return "Failed to decode the response."
        }
    }
}
