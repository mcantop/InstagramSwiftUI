//
//  UserModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 17/11/2022.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable, Equatable {
    @DocumentID var id: String?
    let email: String
    let username: String
    let fullname: String
    let profileImageUrl: String
    
    var bio: String?
    var stats: UserStats?
    var isFollowed: Bool? = false
    var isCurrentUser: Bool { return AuthViewModel.shared.userSession?.uid == id }
}

struct UserStats: Decodable, Equatable {
    var posts: Int
    var followers: Int
    var following: Int
}
