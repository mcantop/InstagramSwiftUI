//
//  SearchView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    @State private var searchText = ""
    @State private var inSearchMode = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 6) {
                SearchBar(text: $searchText, isEditing: $inSearchMode)
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .padding(.bottom, 0)
                
                ZStack {
                    if inSearchMode {
                        UserListView(searchViewModel: viewModel, searchText: $searchText)
                    } else {
                        PostGridView(config: .explore)
                    }
                }
            }
            
            // MARK: - Navigation & Tab bar is sometimes transparent, so I make sure that there is always background behind those elements.
            VStack {
                Spacer()
                
                Rectangle()
                    .fill(Color("BackgroundColor"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .ignoresSafeArea()
            }
            .ignoresSafeArea()
        }
    }
}

struct Searchview_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
