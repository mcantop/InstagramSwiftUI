//
//  EditProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 20/11/2022.
//

import Foundation

final class EditProfileViewModel: ObservableObject {
    @Published var fullname = ""
    @Published var bio: String
    
    private let user: User
    
    init(user: User) {
        self.user = user
        self._bio = State
    }
    
    func editUserData(completion: @escaping() -> Void) {
        guard let uid = user.id else { return }
        
        UserService.editUserData(forUid: uid, bio: bio) {
            completion()
        }
    }
}
