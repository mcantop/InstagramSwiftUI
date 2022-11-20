//
//  CommentModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 19/11/2022.
//

import Firebase
import FirebaseFirestoreSwift

struct Comment: Identifiable, Decodable {
    @DocumentID var id: String?
    let postOwnerUid: String
    let uid: String
    let username: String
    let profileImageUrl: String
    let commentText: String
    let timestamp: Timestamp
    
    var likes: Int
}
