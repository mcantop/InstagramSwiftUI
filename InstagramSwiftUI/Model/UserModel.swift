//
//  UserModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 17/11/2022.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let email: String
    let username: String
    let fullname: String
    let profileImageUrl: String
    
    var isCurrentUser: Bool { return AuthViewModel.shared.userSession?.uid == id }
}
