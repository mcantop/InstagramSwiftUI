//
//  CommentCell.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 19/11/2022.
//

import SwiftUI
import Kingfisher

struct CommentCell: View {
    @ObservedObject var viewModel: CommentCellViewModel
    
    init(comment: Comment) {
        self.viewModel = CommentCellViewModel(comment: comment)
    }
        
    var body: some View {
        HStack(alignment: .top) {
            KFImage(URL(string: viewModel.comment.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(viewModel.comment.username).fontWeight(.semibold) +
                    Text(" ") +
                    Text(viewModel.comment.commentText)
                }.lineSpacing(-10)
                
                HStack {
                    Text(viewModel.timestampString)
                    
                    Text("\(viewModel.comment.likes) likes")
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
