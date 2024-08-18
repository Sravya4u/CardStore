//
//  CardGroupView.swift
//  CardStore
//
//  Created by Sravya Chandrapati on 16/08/24.
//

import SwiftUI

/**
 *  CardGroupsView.swift
 *
 *  Represents a grouped view of cards  by card type
 *  The CardGroupsView struct presents the fetched cards in grouped and sorted list, which are populated from a groupedcards dictionary
 *
 *  - Author: Sravya Chandrapati
 */
struct CardGroupsView: View {
    @ObservedObject var viewModel: CardViewModel
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                CardGroupsSkeletonView()
            } else {
                List {
                    ForEach(viewModel.groupedCards().keys.sorted(), id: \.self) { cardType in
                        NavigationLink(destination: CreditCardListView(viewModel: viewModel, cardType: cardType)) {
                            HStack {
                                Image(uiImage: UIImage(named: cardType.lowercased()) ?? UIImage(named: cardType.lowercased()+"_fallback") ??
                                      UIImage ())
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 30)
                                Text(cardType.capitalized)
                                Spacer()
                                Text("\(viewModel.groupedCards()[cardType]?.count ?? 0)")
                            }
                            .padding(.vertical, 6)
                        }
                    }
                }
                .navigationTitle("Card Groups")
                .alert(item: $viewModel.errorMessage) { errorMessage in
                    Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}
