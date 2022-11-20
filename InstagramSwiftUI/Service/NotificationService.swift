//
//  NotificationService.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 19/11/2022.
//

import Foundation
import Firebase

struct NotificationService {
    static func uploadNotification(toReceivingUid receivingUid: String, type: NotificationType, post: Post? = nil) {
        guard let userSending = AuthViewModel.shared.currentUser else { return }
        guard let userSendingId = userSending.id else { return }
        // Do not send a notification to myself.
        guard receivingUid != userSendingId else { return }
        
        var data: [String: Any] = ["uid": userSendingId,
                                   "timestamp": Timestamp(date: Date()),
                                   "type": type.rawValue]
        
        if let post = post,
           let postId = post.id {
            data["postId"] = postId
        }
        
        COLLECTION_NOTIFICATIONS.document(receivingUid).collection("user-notifications")
            .addDocument(data: data)
    }
    
    static func fetchUserNotifications(completion: @escaping([Notification]) -> Void) {
        guard let uid = AuthViewModel.shared.currentUser?.id else { return }
        
        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
                            
                completion(documents.compactMap( { try? $0.data(as: Notification.self) } ))
        }
    }
}
