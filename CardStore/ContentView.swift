//
//  ContentView.swift
//  CardStore
//
//  Created by Sravya Chandrapati on 16/08/24.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var viewModel = CardViewModel(useMockData:true) // Switch to false for real API

    var body: some View {
        TabView {
            NavigationView {
                CardGroupsView(viewModel: viewModel)
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Card Groups")
            }
            
            NavigationView {
                BookmarksView(viewModel: viewModel)
            }
            .tabItem {
                Image(systemName: "bookmark.fill")
                Text("Bookmarks")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
