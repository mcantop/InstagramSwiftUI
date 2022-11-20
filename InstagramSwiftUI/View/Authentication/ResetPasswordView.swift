//
//  ResetPasswordView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 16/11/2022.
//

import SwiftUI

struct ResetPasswordView: View {
    @StateObject var viewModel = ResetPasswordViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack(spacing: 32) {
                    Text("Reset your password")
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    CustomTextField(value: $viewModel.email, placeholder: "Email Adress", isSecure: false)
                    
                    Button {
                        viewModel.resetPassword()
                    } label: {
                        Text("Reset Password")
                            .frame(maxWidth: .infinity, maxHeight: 20)
                            .padding()
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                            .background(.white.opacity(0.75))
                            .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                    .disabled(viewModel.disableReset())
                    
                    Spacer()
                }
                .padding(.horizontal, 36)
            }
        }
        .font(.callout)
        .foregroundColor(.white)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                }
                
            }
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.showingAlert) {
            if viewModel.alertTitle == "Error" {
                Button("OK", action: { })
            } else {
                Button("Awesome!") {
                    dismiss()
                }
            }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
