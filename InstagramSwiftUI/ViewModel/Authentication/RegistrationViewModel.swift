//
//  RegistrationViewModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 16/11/2022.
//

import Foundation

enum RegistrationViewModel: String, CaseIterable {
    case account
    case profile
    
    var title: String { self.rawValue }
}
