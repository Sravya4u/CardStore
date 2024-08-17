//
//  CardModel.swift
//  CardStore
//
//  Created by Sravya Chandrapati on 16/08/24.
//

import Foundation

import Foundation

struct Card: Identifiable, Codable {
    let id: Int
    let uid: String
    let creditCardNumber: String
    let creditCardExpiryDate: String
    let creditCardType: String

    enum CodingKeys: String, CodingKey {
        case id
        case uid
        case creditCardNumber = "credit_card_number"
        case creditCardExpiryDate = "credit_card_expiry_date"
        case creditCardType = "credit_card_type"
    }
}

