//
//  FeedCellViewModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 18/11/2022.
//

// Importing SwiftUI here just to animate like changes.
import SwiftUI

final class FeedCellViewModel: ObservableObject {
    @Published var comments = 0
    @Published var post: Post
    var currentUser: User?
    
    var likeString: String {
        return post.likes == 1 ? "person" : "people"
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .short
        return formatter.string(from: post.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    init(post: Post) {
        self.post = post
        checkIfUserLikedPosts()
        fetchCurrentUser()
        fetchPostOwner()
        fetchPostComments()
    }
    
    func checkIfUserLikedPosts() {
        PostService.checkIfUserLikes(post) { isLiked in
            self.post.isLiked = isLiked
        }
    }
    
    func like() {
        PostService.likePost(forPost: post) { [self] likes in
            withAnimation(.easeInOut(duration: 0.25)) {
                self.post.isLiked = true
                self.post.likes = likes
                
                NotificationService.uploadNotification(toReceivingUid: post.ownerUid, type: .like, post: post)
            }
        }
    }
    
    func unlike() {
        guard post.likes > 0 else { return }
        
        PostService.unlikePost(forPost: post) { likes in
            withAnimation(.easeInOut(duration: 0.25)) {
                self.post.isLiked = false
                self.post.likes = likes
            }
        }
    }
    
    func fetchCurrentUser() {
        guard let currentUser = AuthViewModel.shared.currentUser else { return }
        
        self.currentUser = currentUser
    }
    
    func fetchPostOwner() {        
        UserService.fetchUser(forUid: post.ownerUid) { owner in
            self.post.owner = owner
        }
    }
    
    func fetchPostComments() {
        CommentService.fetchComments(forPost: post) { comments in
            self.comments = comments.count
        }
    }
}
