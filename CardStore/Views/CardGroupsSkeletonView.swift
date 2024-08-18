//
//  CardGroupsSkeletonView.swift
//  CardStore
//
//  Created by Sravya Chandrapati on 18/08/24.
//

import SwiftUI
/**
 *  CardGroupsSkeletonView.swift
 *
 *  The CardGroupsSkeletonView struct is a skeleton assisting cardGroupView to load gracefully which API fetch is in progress
 *
 *  - Author: Sravya Chandrapati
 */
struct CardGroupsSkeletonView: View {
    var body: some View {
        List {
            ForEach(0..<10, id: \.self) { _ in
                HStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 50, height: 30)
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 20)
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 30, height: 20)
                }
                .padding(.vertical, 6)
            }
        }
        .listStyle(PlainListStyle())  // To Match card list style if necessary
        .navigationTitle("Card Groups")
    }
}









