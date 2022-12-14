//
//  FeedCell.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    @ObservedObject var viewModel: FeedCellViewModel
    private var isLiked: Bool { return viewModel.post.isLiked ?? false }
    
    init(viewModel: FeedCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                NavigationLink {
                    if let user = viewModel.post.owner {
                        LazyView(ProfileView(user: user))
                    }
                } label: {
                    // MARK: - User info
                    HStack {
                        KFImage(URL(string: viewModel.post.owner?.profileImageUrl ?? ""))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 36, height: 36)
                            .clipped()
                            .cornerRadius(18)
                        
                        Text(viewModel.post.owner?.username ?? "")
                            .foregroundColor(Color("TextColor"))
                            .fontWeight(.semibold)
                    }
                }
                .onTapGesture {
                    print("lol")
                }
                .padding(.horizontal, 8)
                
                // MARK: - Post Image
                KFImage(URL(string: viewModel.post.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 350)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 6) {
                    // MARK: - Action Buttons
                    HStack(spacing: 24) {
                        Button {
                            isLiked ? viewModel.unlike() : viewModel.like()
                        } label: {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .resizable()
                                .font(.system(size: 20))
                                .foregroundColor(isLiked ? .red : Color("TextColor"))
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                        }
                        
                        NavigationLink {
                            if let currentUser = viewModel.currentUser {
                                CommentView(post: viewModel.post, currentUser: currentUser)
                                    .toolbar(.hidden, for: .tabBar)
                            }
                        } label: {
                            Image(systemName: "bubble.right")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                                .font(.system(size: 20))
                        }
                        
                        
                        Button {
                            print("DEBUG: Handle action handler..")
                        } label: {
                            Image(systemName: "paperplane")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                                .font(.system(size: 20))
                        }
                    }
                    .foregroundColor(Color("TextColor"))
                    .padding(.top, 4)
                    .padding(.bottom, 4)
                    
                    // MARK: - Likes
                    Text("Liked by") +
                    Text(" ") +
                    Text("\(viewModel.post.likes)").fontWeight(.semibold) +
                    Text(" ") +
                    Text(viewModel.likeString)
                    
                    // MARK: - Caption
                    HStack {
                        Text(viewModel.post.ownerUsername).fontWeight(.semibold) +
                        Text(" ") +
                        Text(viewModel.post.caption)
                    }
                    
                    // MARK: - Comments
                    if viewModel.comments > 0, let currentUser = viewModel.currentUser {
                        NavigationLink {
                            CommentView(post: viewModel.post, currentUser: currentUser)
                                .toolbar(.hidden, for: .tabBar)
                        } label: {
                            Text("View all \(viewModel.comments) comments")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    // MARK: - Timestamp
                    Text(viewModel.timestampString + " ago")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .font(.callout)
                .padding(.horizontal)
            }
    }
}

//struct FeedCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedCell(post: P)
//    }
//}
