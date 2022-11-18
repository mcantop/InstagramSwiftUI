//
//  PostGridView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    @ObservedObject var viewModel: PostGridViewModel
    let config: PostGridConfig
    
    private let items = [GridItem(spacing: 2), GridItem(spacing: 2), GridItem(spacing: 2)]
    private let width = UIScreen.main.bounds.width / 3
    
    init(config: PostGridConfig) {
        self.config = config
        self.viewModel = PostGridViewModel(config: config)
    }
    
    var body: some View {
        LazyVGrid(columns: items, spacing: 1) {
            ForEach(viewModel.posts) { post in
                NavigationLink {
                    FeedView()
                } label: {
                    withAnimation(.easeInOut) {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: width, height: width)
                            .clipped()
                    }
                }

            }
        }
        .animation(.easeInOut, value: viewModel.posts)
    }
}

//struct PostGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostGridView()
//    }
//}
