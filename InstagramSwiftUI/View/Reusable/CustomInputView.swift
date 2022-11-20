//
//  CustomInputView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 19/11/2022.
//

import SwiftUI
import Kingfisher

struct CustomInputView: View {
    @Binding var inputText: String
    let user: User
    var action: () -> Void
    
    var body: some View {
        VStack {
            Divider()
            
            HStack(alignment: .bottom) {
                KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.gray.opacity(0.5), lineWidth: 0.5))
                    .padding(.bottom, 0)

                
                HStack(alignment: .bottom) {
                    TextField("Add a comment...", text: $inputText, axis: .vertical)
                        .padding(8)
                        .lineLimit(6)
                        .frame(minHeight: 45)
                    

                    Button {
                        action()
                    } label: {
                        Text("Post")
                            .bold()
                    }
                    .padding(8)
                    .frame(minHeight: 45)
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.5), lineWidth: 0.5))
            }
            .padding(8)
        }
        .font(.callout)
    }
}

//struct CustomInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomInputView(inputText: .constant(""), user: User(email: "future@mail.com", username: "future", fullname: "Future PLUTO Hendrix", profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-ec865.appspot.com/o/profile_images%2FF7482075-3043-41BE-8583-9C1181944CF0?alt=media&token=5fd8733f-ad4c-4f15-95d1-bc5c865d1541"))
//    }
//}
