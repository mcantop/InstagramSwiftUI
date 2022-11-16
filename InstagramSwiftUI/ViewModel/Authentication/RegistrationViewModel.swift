//
//  RegistrationViewModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 16/11/2022.
//

import SwiftUI
import PhotosUI

enum RegistrationOption: String, CaseIterable {
    case account
    case profile
    
    var title: String { self.rawValue }
}

final class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    @Published var fullname = ""
    @Published var selectedOption: RegistrationOption = .account
    @Published var selectedItem: PhotosPickerItem?
    @Published var selectedUIImage: UIImage?
    @Published var showingAlert = false
    @Published var errorMessage = ""
    
    func register() {
        guard let image = selectedUIImage else { return }
        
        AuthViewModel.shared.register(withEmail: email, password: password, username: username, fullname: fullname, image: image) { error in
            guard let error = error else { return }
            
            self.errorMessage = error
            
            self.showingAlert.toggle()
        }
    }
    
    func disableNext() -> Bool {
        return email.isEmpty || password.isEmpty
    }
    
    func disableSignUp() -> Bool {
        return email.isEmpty || password.isEmpty || username.isEmpty || fullname.isEmpty || selectedItem == nil
    }
}
