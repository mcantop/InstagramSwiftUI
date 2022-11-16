//
//  CustomTextField.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 16/11/2022.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var value: String
    let placeholder: String
    let isSecure: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
                if value.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.white.opacity(0.5))
                }
            if isSecure {
                SecureField("", text: $value)
            } else {
                TextField("", text: $value)
            }
        }
        .frame(height: 20)
        .padding()
        .background(.white.opacity(0.1))
        .cornerRadius(10)
//        .padding(.horizontal)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(value: .constant(""), placeholder: "Email Address", isSecure: false)
    }
}
