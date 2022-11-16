//
//  FeedCell.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI

struct FeedCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // MARK: - User info
            HStack {
                Image("FutureProfile")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .cornerRadius(18)
                
                Text("future")
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 8)
            
            // MARK: - Post Image
            Image("FuturePost")
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
                .foregroundColor(.black)
                .padding(.top, 4)
                .padding(.bottom, 4)
                
                // MARK: - Likes
                Text("Liked by") +
                Text(" ") +
                Text("1 084 383").fontWeight(.semibold) +
                Text(" ") +
                Text("people")
                
                // MARK: - Caption
                HStack {
                    Text("future").fontWeight(.semibold) +
                    Text(" ") +
                    Text("Winning without u.")
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

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell()
    }
}
