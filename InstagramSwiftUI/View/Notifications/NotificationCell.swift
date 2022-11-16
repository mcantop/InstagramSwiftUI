//
//  NotificationCell.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI

struct NotificationCell: View {
    @State private var showPostImage = false
    var username = "future"
    
    var body: some View {
        HStack(spacing: 12) {
            Image("FutureProfile")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            HStack {
                Text("future ")
                    .fontWeight(.semibold) +
                
                Text("started following  \nyou")
                
                Spacer()
            }
            .lineLimit(2)
                        
            if showPostImage {
                Image("FuturePost")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
            } else {
                Button {
                    
                } label: {
                    Text("Follow")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 8)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }

            }
        }
        .font(.callout)
        .padding(.horizontal)
    }
}

struct NotificationCell_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell()
    }
}
