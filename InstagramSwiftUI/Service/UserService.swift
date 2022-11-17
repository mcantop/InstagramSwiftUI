//
//  UserService.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 17/11/2022.
//

import Firebase

struct UserService {
    static func follow(uid: String, completion: @escaping() -> Void) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid)
            .setData([:]) { _ in
                COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid)
                    .setData([:]) { _ in
                        completion()
                    }
            }
    }
    
    static func unfollow(uid: String, completion: @escaping() -> Void) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid)
            .delete { _ in
                COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid)
                    .delete { _ in
                        completion()
                    }
            }
    }
    
    static func checkFollow(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }

        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid)
            .getDocument { snapshot, _ in
                guard let isFollowed = snapshot?.exists else { return }
                
                completion(isFollowed)
            }
    }
}
