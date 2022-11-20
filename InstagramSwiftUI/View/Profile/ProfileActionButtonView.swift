//
//  ProfileActionButtonView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 15/11/2022.
//

import SwiftUI

struct ProfileActionButtonView: View {
    @ObservedObject var viewModel: ProfileViewModel

    private var isFollowed: Bool { return viewModel.user.isFollowed ?? false }
    
    var body: some View {
        if viewModel.user.isCurrentUser {
            Button {
                viewModel.showModal.toggle()
            } label: {
                Text("Edit Profile")
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .foregroundColor(Color("TextColor"))
                    .background(Color("BackgroundColor"))
                    .fontWeight(.semibold)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.gray, lineWidth: 1))
                    .padding(.horizontal)
                    .padding(.vertical, 8)
            }
            .fullScreenCover(isPresented: $viewModel.showModal) {
                EditProfileView(user: $viewModel.user)
            }
        } else {
            HStack {
                Button {
                    withAnimation(.easeInOut) {
                        isFollowed ? viewModel.unfollow() : viewModel.follow()
                    }
                } label: {
                    Text(isFollowed ? "Following" : "Follow")
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .foregroundColor(isFollowed ? Color("TextColor") : .white)
                        .background(isFollowed ? Color("BackgroundColor") : .blue)
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
        ProfileActionButtonView(viewModel: ProfileViewModel(user: User(email: "future@mail.com", username: "future", fullname: "Future PLUTO Hendrix", profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-ec865.appspot.com/o/profile_images%2FF7482075-3043-41BE-8583-9C1181944CF0?alt=media&token=5fd8733f-ad4c-4f15-95d1-bc5c865d1541")))
    }
}
