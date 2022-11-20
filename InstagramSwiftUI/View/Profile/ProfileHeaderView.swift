//
//  ProfileHeaderView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 15/11/2022.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                KFImage(URL(string: viewModel.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                
                Spacer()
                
                HStack(spacing: 16) {
                    UserStatView(number: viewModel.user.stats?.posts ?? 0, text: "Posts")
                    UserStatView(number: viewModel.user.stats?.followers ?? 0, text: "Followers")
                    UserStatView(number: viewModel.user.stats?.following ?? 0, text: "Following")
                }
            }
            .padding(.horizontal)
            
            Text(viewModel.user.fullname)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .padding(.top, 8)
            
            Text(viewModel.user.bio ?? "")
                .padding(.horizontal)
            
            ProfileActionButtonView(viewModel: viewModel)

        }
        .font(.callout)
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(viewModel: ProfileViewModel(user: User(email: "future@mail.com", username: "future", fullname: "Future PLUTO Hendrix", profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-ec865.appspot.com/o/profile_images%2FF7482075-3043-41BE-8583-9C1181944CF0?alt=media&token=5fd8733f-ad4c-4f15-95d1-bc5c865d1541")))
    }
}
