//
//  InstagramSwiftUIApp.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 13/11/2022.
//

import SwiftUI
import Firebase

@main
struct InstagramSwiftUIApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthViewModel.shared)
        }
    }
}
