//
//  PostService.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 18/11/2022.
//

import Foundation

struct PostService {
    static func fetchAllPosts(completion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            completion(documents.compactMap { try? $0.data(as: Post.self) } )
        }
    }
    
    static func fetchUserPosts(forUid uid: String, completion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                completion(documents.compactMap { try? $0.data(as: Post.self) } )
            }
    }
}
