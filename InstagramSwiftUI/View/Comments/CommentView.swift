//
//  CommentView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 19/11/2022.
//

import SwiftUI

struct CommentView: View {
    @ObservedObject var viewModel: CommentViewModel
    
    init(post: Post, currentUser: User) {
        self.viewModel = CommentViewModel(currentUser: currentUser, post: post)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(viewModel.comments) { comment in
                        CommentCell(comment: comment)
                    }
                }
            }
            
            CustomInputView(inputText: $viewModel.commentText, user: viewModel.currentUser, action: viewModel.uploadComment)
        }
        .navigationTitle("Comments")
    }
}

//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView(currentUser: User(email: "future@mail.com", username: "future", fullname: "Future PLUTO Hendrix", profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-ec865.appspot.com/o/profile_images%2FF7482075-3043-41BE-8583-9C1181944CF0?alt=media&token=5fd8733f-ad4c-4f15-95d1-bc5c865d1541"))
//    }
//}
