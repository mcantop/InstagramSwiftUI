//
//  ContentView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 13/11/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginView()
                    .animation(.easeInOut, value: 1)
                    .transition(.move(edge: .bottom))
            } else {
                if let user = viewModel.currentUser {
                    MainTabView(user: user)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
