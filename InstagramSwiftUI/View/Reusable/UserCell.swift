//
//  UserCell.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 12) {
            KFImage(URL(string: user.profileImageUrl))
                .placeholder({ _ in
                    ProgressView()
                })
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(user.username)
                    .fontWeight(.semibold)
                
                Text(user.fullname)
                    .foregroundColor(.gray)
            }
            .font(.callout)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(user: User(email: "future@mail.com", username: "future", fullname: "Future PLUTO Hendrix", profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-ec865.appspot.com/o/profile_images%2FF7482075-3043-41BE-8583-9C1181944CF0?alt=media&token=5fd8733f-ad4c-4f15-95d1-bc5c865d1541"))
    }
}
