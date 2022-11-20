//
//  PostGridViewModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 18/11/2022.
//

import Foundation

enum PostGridConfig {
    case explore
    case profile(String)
}

final class PostGridViewModel: ObservableObject {
    @Published var posts = [Post]()
    let config: PostGridConfig
    
    init(config: PostGridConfig) {
        self.config = config
        self.fetchPosts(forConfig: config)
    }
    
    func fetchPosts(forConfig config: PostGridConfig) {
        switch config {
        case .explore:
            fetchAllPosts()
        case .profile(let uid):
            fetchUserPosts(forUid: uid)
        }
    }
    
    func fetchAllPosts() {
        PostService.fetchExplorePosts { posts in
            self.posts = posts
        }
    }
    
    func fetchUserPosts(forUid uid: String) {
        PostService.fetchUserPosts(forUid: uid) { posts in
            self.posts = posts
        }
    }
}
