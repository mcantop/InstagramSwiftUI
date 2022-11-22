//
//  SearchBar.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) { isEditing = true }
                }
            
            if isEditing {
                Button("Cancel") {
                    text = ""
                    UIApplication.shared.endEditing()
                    withAnimation(.easeInOut(duration: 0.2)) { isEditing = false }
                }
                .foregroundColor(Color("TextColor"))
                .padding(.horizontal, 8)
                .transition(.move(edge: .trailing))
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""), isEditing: .constant(true))
    }
}
