//
//  EditProfileView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 20/11/2022.
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var viewModel: EditProfileViewModel
    @Binding var user: User
    @Environment(\.dismiss) var dismiss
    
    init(user: Binding<User>) {
        self._user = user
        self.viewModel = EditProfileViewModel(user: self._user.wrappedValue)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                CustomTextField(value: $viewModel.fullname, placeholder: "Fullname", isSecure: false)
                CustomTextField(value: $viewModel.bio, placeholder: "Bio", isSecure: false)
                
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Close")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.editUserData {
                            self.user.bio = viewModel.bio
                            dismiss()
                        }
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
}

//struct EditProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfileView()
//    }
//}
