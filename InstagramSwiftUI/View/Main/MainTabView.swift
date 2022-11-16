//
//  MainTabView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        NavigationStack {
            TabView {
                FeedView()
                    .tabItem {
                        Image(systemName: "house")
                            .environment(\.symbolVariants, .none)
                    }
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                            .environment(\.symbolVariants, .none)
                    }
                
                UploadPostView()
                    .tabItem {
                        Image(systemName: "plus.square")
                            .environment(\.symbolVariants, .none)
                    }
                
                NotificationsView()
                    .tabItem {
                        Image(systemName: "heart")
                            .environment(\.symbolVariants, .none)
                    }
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                            .environment(\.symbolVariants, .none)
                    }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(.black)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.easeInOut) {
                            AuthViewModel.shared.signout()
                        }
                    } label: {
                        Image(systemName: "door.left.hand.open")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
