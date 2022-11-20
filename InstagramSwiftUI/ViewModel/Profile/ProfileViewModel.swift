//
//  ProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 17/11/2022.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var showModal = false
    
    init(user: User) {
        self.user = user
        
        checkFollow()
        fetchUserStats()
    }
    
    func follow() {
        guard let uid = user.id else { return }
        
        UserService.follow(uid: uid) {
            self.user.isFollowed = true
            self.user.stats?.followers += 1
            
            NotificationService.uploadNotification(toReceivingUid: uid, type: .follow)
        }
    }
    
    func unfollow() {
        guard let uid = user.id else { return }
        
        UserService.unfollow(uid: uid) {
            self.user.isFollowed = false
            self.user.stats?.followers -= 1
        }
    }
    
    func checkFollow() {
        guard !user.isCurrentUser else { return }
        guard let uid = user.id else { return }
        
        UserService.checkFollow(uid: uid) { isFollowed in
            self.user.isFollowed = isFollowed
        }
    }
    
    func fetchUserStats() {
        guard let uid = user.id else { return }
        
        UserService.fetchUserStats(forUid: uid) { stats in
            self.user.stats = stats
        }
    }
}
