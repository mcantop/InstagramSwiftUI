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
    @Published var currentUser: User?
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchCurrentUser()
    }
    
    func login(withEmail email: String, password: String, completion: @escaping(String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Error while logging user: \(error.localizedDescription)")
                completion(error.localizedDescription)
            }
            
            guard let user = result?.user else { return }
            
            withAnimation(.easeInOut(duration: 0.5)) {
                self.userSession = user
            }
            
            self.fetchCurrentUser()
            
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
            
            ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
                let data = ["uid": user.uid,
                            "email": email,
                            "username": username,
                            "fullname": fullname,
                            "profileImageUrl": imageUrl]
                
                COLLECTION_USERS.document(user.uid)
                    .setData(data) { _ in
                        withAnimation {
                            self.userSession = user
                        }
                        
                        self.fetchCurrentUser()
                        
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
    
    func resetPassword(withEmail email: String, completion: @escaping(Result<Void, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(()))
        }
    }
    
    func fetchCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_USERS.document(uid)
            .getDocument { snapshot, _ in
                guard let user = try? snapshot?.data(as: User.self) else { return }
                                
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.currentUser = user
                }
                
                print("DEBUG: Current username is \(user.username) with \(user.email) address.")
            }
    }
}
