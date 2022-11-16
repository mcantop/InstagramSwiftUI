//
//  AuthViewModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 16/11/2022.
//

import SwiftUI
import Firebase

final class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
    }
    
    func login(withEmail email: String, password: String, completion: @escaping(String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Error while logging user: \(error.localizedDescription)")
                completion(error.localizedDescription)
            }
            
            guard let user = result?.user else { return }
            
            withAnimation(.easeInOut) {
                self.userSession = user
            }
            
            print("DEBUG: Successfully logged a new user!")
        }
    }
    
    func register(withEmail email: String, password: String, username: String, fullname: String, image: UIImage, completion: @escaping(String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Error while registering user: \(error.localizedDescription)")
                completion(error.localizedDescription)
            }
            
            guard let user = result?.user else { return }
            
            ImageUploader.uploadImage(image: image) { imageUrl in
                let data = ["uid": user.uid,
                            "email": email,
                            "username": username,
                            "fullname": fullname,
                            "profileImageUrl": imageUrl]
                
                Firestore.firestore().collection("users").document(user.uid)
                    .setData(data) { _ in
                        withAnimation {
                            self.userSession = user
                        }
                        print("DEBUG: Successfully registered a new user!")
                    }
            }
        }
    }
    
    func signout() {
        try? Auth.auth().signOut()
        self.userSession = nil
        print("DEBUG: User signed out.")
    }
    
    func resetPassword() {
        print("DEBUG: Reset password.")
    }
    
    func fetchUser() {
        print("DEBUG: Fetch user.")
    }
}
