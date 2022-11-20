//
//  PostService.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 18/11/2022.
//

import Foundation

struct PostService {
    static func fetchPost(forPostId postId: String, completion: @escaping(Post) -> Void) {
        COLLECTION_POSTS.document(postId)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                guard let post = try? snapshot.data(as: Post.self) else { return }
                        
                completion(post)
            }
    }
    
    static func fetchExplorePosts(completion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                completion(documents.compactMap { try? $0.data(as: Post.self) } )
            }
    }
    
    static func fetchUserPosts(forUid uid: String, completion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let posts = documents.compactMap { try? $0.data(as: Post.self) }
                completion(posts.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
    
    static func likePost(forPost post: Post, completion: @escaping(Int) -> Void) {
        guard let uid = AuthViewModel.shared.currentUser?.id else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_POSTS.document(postId).collection("post-likes").document(uid)
            .setData([:]) { _ in
                COLLECTION_USERS.document(uid).collection("user-likes").document(postId)
                    .setData([:]) { _ in
                        let likes = post.likes + 1
                                                
                        COLLECTION_POSTS.document(postId).updateData(["likes": likes])
                        
                        completion(likes)
                    }
            }
    }
    
    static func unlikePost(forPost post: Post, completion: @escaping(Int) -> Void) {
        guard let uid = AuthViewModel.shared.currentUser?.id else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_POSTS.document(postId).collection("post-likes").document(uid)
            .delete { _ in
                COLLECTION_USERS.document(uid).collection("user-likes").document(postId)
                    .delete { _ in
                        let likes = post.likes - 1
                        
                        COLLECTION_POSTS.document(postId).updateData(["likes": likes])
                        
                        completion(likes)
                    }
            }
    }
    
    static func checkIfUserLikes(_ post: Post, completion: @escaping(Bool) -> Void) {
        guard let uid = AuthViewModel.shared.currentUser?.id else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_USERS.document(uid).collection("user-likes").document(postId)
            .getDocument { snapshot, _ in
                guard let isLiked = snapshot?.exists else { return }
                
                completion(isLiked)
            }
    }
}
