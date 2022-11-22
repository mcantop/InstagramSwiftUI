//
//  FeedView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                // LazyVStack stutter bug
                VStack(spacing: 32) {
                    ForEach(viewModel.posts) { post in
                        FeedCell(viewModel: FeedCellViewModel(post: post))
                    }
                }
                .padding(.top)
                
            }
            .toolbarBackground(Color("BackgroundColor"), for: .tabBar)
            .refreshable {
                viewModel.fetchPosts()
            }
            
            // MARK: - Navigation & Tab bar is sometimes transparent, so I make sure that there is always background behind those elements.
            VStack {
                Rectangle()
                    .fill(Color("BackgroundColor"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 90)
                    .edgesIgnoringSafeArea(.top)
                
                Spacer()
            }
        }
    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}
