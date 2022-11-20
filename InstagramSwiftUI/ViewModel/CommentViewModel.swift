//
//  CommentViewModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 19/11/2022.
//

import Foundation

final class CommentViewModel: ObservableObject {
    @Published var comments = [Comment]()
    @Published var currentUser: User
    @Published var commentText = ""
    private let post: Post
    
    init(currentUser: User, post: Post) {
        self.currentUser = currentUser
        self.post = post
        fetchComments()
    }
    
    func fetchComments() {
        CommentService.fetchComments(forPost: post) { comments in
            self.comments.append(contentsOf: comments)
        }
    }
    
    func uploadComment() {
        CommentService.uploadComment(post: post, commentText: commentText)
        commentText = ""
        NotificationService.uploadNotification(toReceivingUid: post.ownerUid, type: .comment, post: post)
    }
}
