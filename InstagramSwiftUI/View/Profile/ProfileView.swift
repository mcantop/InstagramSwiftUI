//
//  ProfileView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ProfileHeaderView(viewModel: ProfileViewModel(user: user))
                    
                    PostGridView(config: .profile(user.id ?? ""))
                }
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
            
            .navigationTitle(user.username)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(email: "future@mail.com", username: "future", fullname: "Future PLUTO Hendrix", profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-ec865.appspot.com/o/profile_images%2FF7482075-3043-41BE-8583-9C1181944CF0?alt=media&token=5fd8733f-ad4c-4f15-95d1-bc5c865d1541"))
    }
}
