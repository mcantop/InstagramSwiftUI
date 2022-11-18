//
//  FeedViewModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 18/11/2022.
//

import Foundation

final class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        PostService.fetchAllPosts { posts in
            self.posts = posts
        }
    }
}
