//
//  RegistrationView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 16/11/2022.
//

import SwiftUI
import PhotosUI

struct RegistrationView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @Namespace var animation
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var selectedOption: RegistrationViewModel = .account
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedUIImage: UIImage?
    
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
                        ForEach(RegistrationViewModel.allCases, id: \.rawValue) { option in
                            VStack {
                                Text(option.title.capitalized)
                                    .bold()
                                    .foregroundColor(selectedOption == option ? .white : .white.opacity(0.75))
                                
                                if selectedOption == option {
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
                                    selectedOption = option
                                }
                            }
                        }
                    }
                    
                    if selectedOption == .account {
                        VStack(spacing: 16) {
                            CustomTextField(value: $email, placeholder: "Email Address", isSecure: false)
                            CustomTextField(value: $password, placeholder: "Password", isSecure: true)
                            
                            Button {
                                withAnimation(.easeInOut) {
                                    selectedOption = .profile
                                }
                            } label: {
                                Text("Next")
                                    .frame(maxWidth: .infinity, maxHeight: 20)
                                    .padding()
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.blue)
                                    .background(selectedOption == .account ? .white.opacity(0.75) : .white.opacity(0.0))
                                    .cornerRadius(10)
                            }
                        }
                    } else {
                        VStack(spacing: 16) {
                            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                                if let selectedUIImage {
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
                            .onChange(of: selectedItem) { newItem in
                                Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        withAnimation {
                                            self.selectedUIImage = UIImage(data: data)
                                        }
                                    }
                                }
                            }
                            
                            CustomTextField(value: $username, placeholder: "@username", isSecure: false)
                            CustomTextField(value: $fullname, placeholder: "Fullname", isSecure: false)
                            
                            Button {
                                guard let image = selectedUIImage else { return }
                                
                                withAnimation(.easeInOut) {
                                    authViewModel.register(withEmail: email, password: password, username: username, fullname: fullname, image: image)
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
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
