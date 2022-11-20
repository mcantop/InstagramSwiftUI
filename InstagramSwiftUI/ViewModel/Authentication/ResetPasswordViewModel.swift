//
//  ResetPasswordViewModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 20/11/2022.
//

import Foundation

final class ResetPasswordViewModel: ObservableObject {
    @Published var email = ""
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showingAlert = false
    
    func disableReset() -> Bool {
        return email.isEmpty
    }
    
    func resetPassword() {
        AuthViewModel.shared.resetPassword(withEmail: email) { result in
            switch result {
            case .failure(let error):
                self.alertTitle = "Error"
                self.alertMessage = error.localizedDescription
                self.showingAlert.toggle()
            case .success:
                self.alertTitle = "Success"
                self.alertMessage = "An email with password recovery has been sent. Please check your inbox."
                self.showingAlert.toggle()
            }
        }
    }
}
