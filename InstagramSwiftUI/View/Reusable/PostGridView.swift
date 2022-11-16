//
//  PostGridView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI

struct PostGridView: View {
    private let items = [GridItem(spacing: 2), GridItem(spacing: 2), GridItem(spacing: 2)]
    private let width = UIScreen.main.bounds.width / 3
    
    var body: some View {
        LazyVGrid(columns: items, spacing: 1) {
            ForEach(0..<10) { _ in
                NavigationLink {
                    FeedView()
                } label: {
                    Image("FuturePost")
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: width)
                        .clipped()
                }

            }
        }
    }
}

struct PostGridView_Previews: PreviewProvider {
    static var previews: some View {
        PostGridView()
    }
}
