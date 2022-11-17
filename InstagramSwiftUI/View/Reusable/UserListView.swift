//
//  UserListView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @Binding var searchText: String
    
    private var users: [User] {
        return searchText.isEmpty ? searchViewModel.users : searchViewModel.filterUsers(searchText)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(users) { user in
                    NavigationLink {
                        ProfileView(user: user)
                    } label: {
                        UserCell(user: user)
                    }
                }
            }
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView(searchViewModel: SearchViewModel(), searchText: .constant(""))
    }
}
