//
//  CommentService.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 19/11/2022.
//

import Foundation
import Firebase

struct CommentService {
    static func fetchComments(forPost post: Post, completion: @escaping([Comment]) -> Void) {
        guard let postId = post.id else { return }
        
        let query = COLLECTION_POSTS.document(postId).collection("post-comments").order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, _ in
            guard let addedDocs = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            
            completion(addedDocs.compactMap({ try? $0.document.data(as: Comment.self) }))
        }
    }
    
    static func uploadComment(post: Post, commentText: String) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let postId = post.id else { return }
        
        let data = ["username": user.username,
                    "profileImageUrl": user.profileImageUrl,
                    "uid": user.id ?? "",
                    "commentText": commentText,
                    "likes": 0,
                    "timestamp": Timestamp(date: Date()),
                    "postOwnerUid": post.ownerUid] as [String: Any]
        
        COLLECTION_POSTS.document(postId).collection("post-comments")
            .addDocument(data: data)
    }
}
