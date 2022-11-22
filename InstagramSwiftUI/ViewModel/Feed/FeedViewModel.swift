//
//  FeedViewModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 18/11/2022.
//

import SwiftUI

final class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        PostService.fetchExplorePosts { posts in
            withAnimation(.easeInOut) {
                self.posts = posts.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
            }
        }
    }
}
