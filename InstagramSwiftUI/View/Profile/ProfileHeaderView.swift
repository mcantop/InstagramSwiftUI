//
//  ProfileHeaderView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 15/11/2022.
//

import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Image("FutureProfile")
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
            
            Text("Future PLUTO Hendrix")
                .fontWeight(.semibold)
                .padding(.horizontal)
                .padding(.top, 8)
            
            Text("I Never Liked You out now")
                .padding(.horizontal)
            
            ProfileActionButtonView()

        }
        .font(.callout)
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
    }
}
