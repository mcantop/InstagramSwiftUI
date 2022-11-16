//
//  SearchView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var inSearchMode = false
    
    var body: some View {
        
        ScrollView {
            SearchBar(text: $searchText, isEditing: $inSearchMode)
                .padding()
            
            ZStack {
                if inSearchMode {
                    UserListView()
                } else {
                    PostGridView()
                }
            }
        }
    }
}

struct Searchview_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
