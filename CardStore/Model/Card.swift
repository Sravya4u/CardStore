//
//  CardModel.swift
//  CardStore
//
//  Created by Sravya Chandrapati on 16/08/24.
//

import Foundation
/**
*  Card.swift
*
*  Represents a card entity, adhering to the SOLID principles by following clear separation of concerns and single responsibility.
*  It conforms to the Codable protocol for encoding and decoding, ensuring data interchangeability.
*
*  - Author: Sravya Chandrapati
*/
struct Card: Identifiable, Codable {
    let id: Int
    let uid: String
    let creditCardNumber: String
    let creditCardExpiryDate: String
    let creditCardType: String
    var isBookmarked: Bool = false // New property to track bookmark state
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case uid
        case creditCardNumber = "credit_card_number"
        case creditCardExpiryDate = "credit_card_expiry_date"
        case creditCardType = "credit_card_type"
    }
}

