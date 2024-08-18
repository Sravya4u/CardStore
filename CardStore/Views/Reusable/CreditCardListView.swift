//
//  CreditCardListView.swift
//  CardStore
//
//  Created by Sravya Chandrapati on 17/08/24.
//
import SwiftUI

/**
 *  CreditCardListView.swift
 *
 *  Displays a list of card groups in a tabbed scrollable view, along with a tab for bookmarks to refer.
 *  The CreditCardListView struct is responsible for presenting cards from selected group of  card type in a list.
 *
 *  - Author: Sravya Chandrapati
 */
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
