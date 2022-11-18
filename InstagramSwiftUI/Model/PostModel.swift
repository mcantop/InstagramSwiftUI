//
//  PostModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 18/11/2022.
//

import Firebase
import FirebaseFirestoreSwift

struct Post: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    let ownerUid: String
    let ownerUsername: String
    let ownerImageUrl: String
    let imageUrl: String
    let caption: String
    let likes: Int
    let timestamp: Timestamp
}
