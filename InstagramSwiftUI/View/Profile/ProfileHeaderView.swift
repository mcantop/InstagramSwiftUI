//
//  ProfileHeaderView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 15/11/2022.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                
                Spacer()
                
                HStack(spacing: 16) {
                    UserStatView(number: 3, text: "Posts")
                    UserStatView(number: 9183960, text: "Followers")
                    UserStatView(number: 0, text: "Following")
                }
            }
            .padding(.horizontal)
            
            Text(user.fullname)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .padding(.top, 8)
            
            Text("I Never Liked You out now")
                .padding(.horizontal)
            
            ProfileActionButtonView(isCurrentUser: user.isCurrentUser)

        }
        .font(.callout)
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(user: User(email: "future@mail.com", username: "future", fullname: "Future PLUTO Hendrix", profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-ec865.appspot.com/o/profile_images%2FF7482075-3043-41BE-8583-9C1181944CF0?alt=media&token=5fd8733f-ad4c-4f15-95d1-bc5c865d1541"))
    }
}
