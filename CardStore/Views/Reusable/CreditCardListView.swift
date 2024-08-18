//
//  CreditCardListView.swift
//  CardStore
//
//  Created by Sravya Chandrapati on 17/08/24.
//
import SwiftUI

struct CreditCardListView: View {
    @ObservedObject var viewModel: CardViewModel
    var cardType: String

    var body: some View {
        List {
            ForEach(viewModel.groupedCards()[cardType] ?? []) { card in
                CreditCardView(viewModel: viewModel, card: card)
            }
        }
        .navigationTitle(cardType.capitalized)
    }
}
