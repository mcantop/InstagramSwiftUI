//
//  UserStatView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 15/11/2022.
//

import SwiftUI

struct UserStatView: View {
    let number: Int
    let text: String
    
    var body: some View {
        VStack {
            Text("\(number)")
                .font(.callout)
                .fontWeight(.semibold)
            
            Text(text)
        }
        .frame(width: 80, alignment: .center)
    }
}

struct UserStatView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatView(number: 220398, text: "Followers")
    }
}
