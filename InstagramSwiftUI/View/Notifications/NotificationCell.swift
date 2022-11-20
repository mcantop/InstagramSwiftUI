//
//  NotificationCell.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    @ObservedObject var viewModel: NotificationCellViewModel
    var isFollowed: Bool { return viewModel.notification.isFollowed ?? false }
    
    init(viewModel: NotificationCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 12) {
            if let user = viewModel.notification.user {
                NavigationLink {
                    ProfileView(user: user)
                } label: {
                    KFImage(URL(string: viewModel.notification.user?.profileImageUrl ?? ""))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    HStack {
                        Text(viewModel.notification.user?.username ?? "")
                            .fontWeight(.semibold) +
                        
                        Text(viewModel.notification.type.message)
                        
                        Spacer()
                    }
                    .multilineTextAlignment(.leading)
                }
            }

                        
            if viewModel.notification.type != .follow {
                if let post = viewModel.notification.post {
                    NavigationLink {
                        VStack {
                            FeedCell(viewModel: FeedCellViewModel(post: post))
                            
                            Spacer()
                        }
                    } label: {
                        KFImage(URL(string: viewModel.notification.post?.imageUrl ?? ""))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipped()
                    }
                }
            } else {
                Button {
                    isFollowed ? viewModel.unfollow() : viewModel.follow()
                } label: {
                    Text(isFollowed ? "Following" : "Follow")
                        .frame(width: 100, height: 40)
                        .foregroundColor(isFollowed ? Color("TextColor") : .white)
                        .background(isFollowed ? Color("BackgroundColor") : .blue)
                        .fontWeight(.semibold)
                        .cornerRadius(isFollowed ? 0 : 10)
                        .overlay(RoundedRectangle(cornerRadius: isFollowed ? 3 : 10).stroke(Color.gray, lineWidth: isFollowed ? 1 : 0))
                }

            }
        }
        .font(.callout)
        .padding(.horizontal)
    }
}

//struct NotificationCell_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationCell()
//    }
//}
