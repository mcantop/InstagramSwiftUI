//
//  SearchViewModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 17/11/2022.
//

import Foundation

final class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        fetchAllUsers()
    }
    
    func fetchAllUsers() {
        UserService.fetchAllUsers { users in
            self.users = users
        }
    }
    
    func filterUsers(_ query: String) -> [User] {
        return users.filter {
            $0.username.contains(query.lowercased()) ||
            $0.fullname.lowercased().contains(query.lowercased())
        }
    }
}
