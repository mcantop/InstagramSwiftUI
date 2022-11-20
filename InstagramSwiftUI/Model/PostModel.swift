//
//  PostModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 18/11/2022.
//

import Firebase
import FirebaseFirestoreSwift

struct Post: Identifiable, Decodable, Equatable {
    @DocumentID var id: String?
    let ownerUid: String
    let ownerUsername: String
    let ownerImageUrl: String
    let imageUrl: String
    let caption: String
    var likes: Int
    let timestamp: Timestamp
    
    var isLiked: Bool? = false
    var owner: User?
}
