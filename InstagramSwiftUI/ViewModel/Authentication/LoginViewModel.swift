//
//  LoginViewModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 16/11/2022.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var showingAlert = false
    @Published var errorMessage = ""
    
    func login() {
            AuthViewModel.shared.login(withEmail: email, password: password) { error in
                guard let error = error else { return }
                
                self.errorMessage = error
                self.showingAlert.toggle()
            }
    }
    
    func disableLogin() -> Bool {
        email.isEmpty || password.isEmpty
    }
}
