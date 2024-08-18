//
//  BookmarksView.swift
//  CardStore
//
//  Created by Sravya Chandrapati on 17/08/24.
//

import SwiftUI

struct BookmarksView: View {
    @ObservedObject var viewModel: CardViewModel

    var body: some View {
        List(viewModel.bookmarks) { card in
            CreditCardView(viewModel: viewModel, card: card)
        }
        .navigationTitle("Bookmarks")
    }
}
