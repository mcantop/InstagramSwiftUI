//
//  ProfileActionButtonView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 15/11/2022.
//

import SwiftUI

struct ProfileActionButtonView: View {
    var isCurrentUser: Bool
    var isFollowed = false
    
    var body: some View {
        if isCurrentUser {
            Button {
                
            } label: {
                Text("Edit Profile")
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.gray, lineWidth: 1))
                    .padding(.horizontal)
                    .padding(.vertical, 8)
            }
        } else {
            HStack {
                Button {
                    
                } label: {
                    Text(isFollowed ? "Following" : "Follow")
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .foregroundColor(isFollowed ? Color("TextColor") : .white)
                        .background(isFollowed ? Color("BackgroundColo") : .blue)
                        .fontWeight(.semibold)
                        .cornerRadius(isFollowed ? 0 : 10)
                        .overlay(RoundedRectangle(cornerRadius: isFollowed ? 3 : 10).stroke(Color.gray, lineWidth: isFollowed ? 1 : 0))
                }
                
                Button {
                    
                } label: {
                    Text("Message")
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .foregroundColor(Color("TextColor"))
                        .fontWeight(.semibold)
                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.gray, lineWidth: 1))
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
        }
    }
}

struct ProfileActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileActionButtonView(isCurrentUser: false)
    }
}
