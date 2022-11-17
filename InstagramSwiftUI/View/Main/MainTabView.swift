//
//  MainTabView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI

struct MainTabView: View {
    let user: User
    
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
                
                ProfileView(user: user)
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                            .environment(\.symbolVariants, .none)
                    }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(Color("TextColor"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.easeInOut) {
                            AuthViewModel.shared.signout()
                        }
                    } label: {
                        Image(systemName: "door.left.hand.open")
                            .foregroundColor(Color("TextColor"))
                    }
                }
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(user: User(email: "future@mail.com", username: "future", fullname: "Future PLUTO Hendrix", profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-ec865.appspot.com/o/profile_images%2FF7482075-3043-41BE-8583-9C1181944CF0?alt=media&token=5fd8733f-ad4c-4f15-95d1-bc5c865d1541"))
    }
}
