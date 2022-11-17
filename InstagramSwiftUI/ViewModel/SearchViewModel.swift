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
        COLLECTION_USERS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            self.users = documents.compactMap { try? $0.data(as: User.self) }
            }
    }
    
    func filterUsers(_ query: String) -> [User] {
        return users.filter {
            $0.username.contains(query.lowercased()) ||
            $0.fullname.lowercased().contains(query.lowercased())
        }
    }
}
