//
//  CommentCellViewModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 20/11/2022.
//

import Foundation

final class CommentCellViewModel: ObservableObject {
    let comment: Comment
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: comment.timestamp.dateValue(), to: Date()) ?? ""
    }
}
