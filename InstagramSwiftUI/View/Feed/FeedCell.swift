//
//  FeedCell.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // MARK: - User info
            HStack {
                KFImage(URL(string: post.ownerImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .cornerRadius(18)
                
                Text(post.ownerUsername)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 8)
            
            // MARK: - Post Image
            KFImage(URL(string: post.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(maxHeight: 440)
                .clipped()
            
            VStack(alignment: .leading, spacing: 6) {
                // MARK: - Action Buttons
                HStack(spacing: 24) {
                    Button {
                        print("DEBUG: Handle action handler..")
                    } label: {
                        Image(systemName: "heart")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                            .font(.system(size: 20))
                    }
                    
                    Button {
                        print("DEBUG: Handle action handler..")
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
                Text("\(post.likes)").fontWeight(.semibold) +
                Text(" ") +
                Text("people")
                
                // MARK: - Caption
                HStack {
                    Text(post.ownerUsername).fontWeight(.semibold) +
                    Text(" ") +
                    Text(post.caption)
                }
                
                // MARK: - Timestamp
                Text("19w")
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
