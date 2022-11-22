//
//  NotificationCellViewModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 19/11/2022.
//

import SwiftUI

final class NotificationCellViewModel: ObservableObject {
    @Published var notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
        
        fetchNotificationUser()
        checkFollow()
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    func follow() {
        UserService.follow(uid: notification.uid) {
            self.notification.isFollowed = true
            
            NotificationService.uploadNotification(toReceivingUid: self.notification.uid, type: .follow)
        }
    }
    
    func unfollow() {
        UserService.unfollow(uid: notification.uid) {
            self.notification.isFollowed = false
        }
    }
    
    func checkFollow() {
        guard notification.type == .follow else { return }
        
        UserService.checkFollow(uid: notification.uid) { isFollowed in
            self.notification.isFollowed = isFollowed
        }
    }
    
    func fetchNotificationPost() {
        guard let postId = notification.postId else { return }
        
        PostService.fetchPost(forPostId: postId) { post in
//            withAnimation {
                self.notification.post = post
//            }
        }
    }
    
    func fetchNotificationUser() {
        UserService.fetchUser(forUid: notification.uid) { user in
            withAnimation(.default) {
                self.notification.user = user
                self.fetchNotificationPost()
            }
        }
    }
}
