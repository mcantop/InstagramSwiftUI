//
//  CommentCell.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 19/11/2022.
//

import SwiftUI
import Kingfisher

struct CommentCell: View {
    let comment: Comment
    
    var body: some View {
        HStack(alignment: .top) {
            KFImage(URL(string: comment.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(comment.username).fontWeight(.semibold) +
                    Text(" ") +
                    Text(comment.commentText)
                }.lineSpacing(-10)
                
                HStack {
                    Text("2m")
                    
                    Text("\(comment.likes) likes")
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
        }
        .font(.callout)
        .padding(.horizontal)
    }
}

//struct CommentCell_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentCell()
//    }
//}
