//
//  ContentView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 13/11/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var selectedIndex = 0
    
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginView()
                    .animation(.easeInOut, value: 1)
                    .transition(.move(edge: .bottom))
            } else {
                if let user = viewModel.currentUser {
                    MainTabView(selectedIndex: $selectedIndex, user: user)
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
