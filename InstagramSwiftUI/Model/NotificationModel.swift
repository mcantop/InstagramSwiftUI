//
//  NotificationModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 19/11/2022.
//

import Firebase
import FirebaseFirestoreSwift

enum NotificationType: Int, Decodable {
    case like
    case comment
    case follow
    
    var message: String {
        switch self {
        case .like: return " liked your post."
        case .comment: return " commented on your post."
        case .follow: return " started following you."
        }
    }
}

struct Notification: Identifiable, Decodable {
    @DocumentID var id: String?
    let uid: String
    let type: NotificationType
    let timestamp: Timestamp
    
    var user: User?
    var post: Post?
    var postId: String?
    var isFollowed: Bool? = false
}
