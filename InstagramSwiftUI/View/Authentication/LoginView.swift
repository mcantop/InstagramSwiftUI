//
//  LoginView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 16/11/2022.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
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
                        CustomTextField(value: $viewModel.email, placeholder: "Email Address", isSecure: false)
                        CustomTextField(value: $viewModel.password, placeholder: "Password", isSecure: true)
                        
                        NavigationLink(destination: ResetPasswordView()) {
                            Text("Forgotten password?")
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                        
                        Button {
                            viewModel.login()
                        } label: {
                            Text("Log In")
                                .frame(maxWidth: .infinity, maxHeight: 20)
                                .padding()
                                .fontWeight(.semibold)
                                .foregroundStyle(.blue)
                                .background(.white.opacity(0.75))
                                .cornerRadius(10)
                        }
                        .buttonStyle(.plain)
                        .disabled(viewModel.disableLogin())
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
        .alert("Error", isPresented: $viewModel.showingAlert) {
            Button("Close", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
