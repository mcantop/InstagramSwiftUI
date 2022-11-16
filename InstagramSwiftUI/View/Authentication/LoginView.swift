//
//  LoginView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 16/11/2022.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    Spacer()
                    
                    Image("InstagramTextLogo")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(maxWidth: 220)
                    
                    VStack(spacing: 16) {
                            CustomTextField(value: $email, placeholder: "Email Address", isSecure: false)
                            CustomTextField(value: $password, placeholder: "Password", isSecure: true)
                        
                        NavigationLink(destination: ResetPasswordView()) {
                            Text("Forgotten password?")
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                        
                        Button {
                            withAnimation(.easeInOut) {
                                authViewModel.login(withEmail: email, password: password)
                            }
                        } label: {
                            Text("Log In")
                                .frame(maxWidth: .infinity, maxHeight: 20)
                                .padding()
                                .fontWeight(.semibold)
                                .foregroundStyle(.blue)
                                .background(.white.opacity(0.75))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                            
                    Spacer()
                    
                    VStack(spacing: 32) {
                        Divider()
                            .background(.white)
                        
                        HStack(spacing: 4) {
                            Text("Don't have an account?")
                            
                            NavigationLink(destination: RegistrationView()) {
                                Text("Sign Up")
                                    .fontWeight(.bold)
                            }
                        }
                        .font(.footnote)
                    }
                }
            }
        }
        .font(.callout)
        .foregroundColor(.white)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
