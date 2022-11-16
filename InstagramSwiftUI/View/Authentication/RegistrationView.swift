//
//  RegistrationView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 16/11/2022.
//

import SwiftUI
import PhotosUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss
    @Namespace var animation
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack(spacing: 32) {

                    Text("Enter your credentials and profile info")
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    HStack(spacing: 0) {
                        ForEach(RegistrationOption.allCases, id: \.rawValue) { option in
                            VStack {
                                Text(option.title.capitalized)
                                    .bold()
                                    .foregroundColor(viewModel.selectedOption == option ? .white : .white.opacity(0.75))
                                
                                if viewModel.selectedOption == option {
                                    Capsule()
                                        .foregroundColor(.white)
                                        .frame(height: 3)
                                        .matchedGeometryEffect(id: "filter", in: animation)
                                } else {
                                    Capsule()
                                        .foregroundColor(.white.opacity(0.5))
                                        .foregroundColor(.clear)
                                        .frame(height: 3)
                                }
                            }
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    viewModel.selectedOption = option
                                }
                            }
                        }
                    }
                    
                    if viewModel.selectedOption == .account {
                        VStack(spacing: 16) {
                            CustomTextField(value: $viewModel.email, placeholder: "Email Address", isSecure: false)
                            CustomTextField(value: $viewModel.password, placeholder: "Password", isSecure: true)
                            
                            Button {
                                withAnimation(.easeInOut) {
                                viewModel.selectedOption = .profile
                                }
                            } label: {
                                Text("Next")
                                    .frame(maxWidth: .infinity, maxHeight: 20)
                                    .padding()
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.blue)
                                    .background(viewModel.selectedOption == .account ? .white.opacity(0.75) : .white.opacity(0.0))
                                    .cornerRadius(10)
                            }
                            .buttonStyle(.plain)
                            .disabled(viewModel.disableNext())
                        }
                    } else {
                        VStack(spacing: 16) {
                            PhotosPicker(selection: $viewModel.selectedItem, matching: .images, photoLibrary: .shared()) {
                                if let selectedUIImage = viewModel.selectedUIImage {
                                    Image(uiImage: selectedUIImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(.white, lineWidth: 2))
                                } else {
                                    ZStack {
                                        Circle()
                                            .fill(.white.opacity(0.05))
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(.white, lineWidth: 2))
                                        
                                        Image(systemName: "plus")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                    }
                                }
                            }
                            .onChange(of: viewModel.selectedItem) { newItem in
                                Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        withAnimation {
                                            self.viewModel.selectedUIImage = UIImage(data: data)
                                        }
                                    }
                                }
                            }
                            
                            CustomTextField(value: $viewModel.username, placeholder: "@username", isSecure: false)
                            CustomTextField(value: $viewModel.fullname, placeholder: "Fullname", isSecure: false)
                            
                            Button {                                
                                withAnimation(.easeInOut) {
                                    viewModel.register()
                                }
                            } label: {
                                Text("Sign Up")
                                    .frame(maxWidth: .infinity, maxHeight: 20)
                                    .padding()
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.blue)
                                    .background(.white.opacity(0.75))
                                    .cornerRadius(10)
                            }
                            .buttonStyle(.plain)
                            .disabled(viewModel.disableSignUp())
                        }
                    }
                            
                    Spacer()
                }
                .padding(.horizontal, 36)
                
                VStack(spacing: 32) {
                    Spacer()
                    
                    Divider()
                        .background(.white)
                    
                    HStack(spacing: 4) {
                        Text("Already have an account?")
                        
                        Button("Log In") {
                            dismiss()
                        }
                        .fontWeight(.bold)
                    }
                    .font(.footnote)
                }
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
        .alert("Error", isPresented: $viewModel.showingAlert) {
            Button("Close", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environmentObject(AuthViewModel())
    }
}
