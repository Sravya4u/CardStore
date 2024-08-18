//
//  CreditCardView.swift
//  CardStore
//
//  Created by Sravya Chandrapati on 17/08/24.
//

import SwiftUI

struct CreditCardView: View {
    @ObservedObject var viewModel: CardViewModel
    let card: Card
    
    var body: some View {
        GeometryReader { geometry in
        ZStack {
            // Card Background
            ZStack {
                // Card Background with Image
                if let backgroundImage = UIImage(named: card.creditCardType.lowercased()) {
                    Image(uiImage: backgroundImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()  // Ensure the image doesn't overflow the bounds
                        .cornerRadius(15) // Maintain the corner radius
                        .shadow(radius: 10)
                } else {
                    // Fallback Gradient Background if image is not found
                    RoundedRectangle(cornerRadius: 15)
                        .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: geometry.size.width,height: 200)
                        .shadow(radius: 10)
                }
            }
            VStack(alignment: .leading, spacing: 20) {
                // Card Type Icon
                HStack {
                    if UIImage(named: card.creditCardType.lowercased()) == nil {
                            Image(card.creditCardType.lowercased()+"_fallback")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 30)
                    }
                    Spacer()
                    Spacer()
                                        
                                        // Bookmark Toggle Button
                                        Button(action: {
                                            
                                            viewModel.toggleBookmark(card: card)
                                        }) {
                                            Image(systemName: card.isBookmarked ? "bookmark.fill" : "bookmark")
                                                .foregroundColor(card.isBookmarked ? .yellow : .white)
                                                .padding(.trailing, 10)
                                        }
                                        .buttonStyle(PlainButtonStyle()) // Optional: Customize button style
                }
                Spacer()
                // Credit Card Number
                Text(card.creditCardNumber)
                    .font(.system(size: 24, weight: .bold, design: .monospaced))
                    .foregroundColor(.white)
                    .lineLimit(1) // Prevents the text from wrapping into two lines
                        .minimumScaleFactor(0.8)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Valid Thru")
                            .font(.caption)
                            .foregroundColor(.white)
                        Text(card.creditCardExpiryDate)
                            .font(.system(size: 18, weight: .bold, design: .monospaced))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
            }
            .padding()
        }
        .padding(.horizontal)
        .frame(width: geometry.size.width, height: 200, alignment: .center)
        }
        .aspectRatio(3/2, contentMode: .fit) // Maintain aspect ratio for the card view
    }
}

