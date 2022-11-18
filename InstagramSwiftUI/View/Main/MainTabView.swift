//
//  MainTabView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI

struct MainTabView: View {
    @Binding var selectedIndex: Int
    let user: User
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedIndex) {
                FeedView()
                    .onTapGesture { selectedIndex = 0 }
                    .tag(0)
                    .tabItem {
                        Image(systemName: "house")
                            .environment(\.symbolVariants, .none)
                    }
                
                SearchView()
                    .onTapGesture { selectedIndex = 1 }
                    .tag(1)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                            .environment(\.symbolVariants, .none)
                    }
                
                UploadPostView(selectedIndex: $selectedIndex)
                    .onTapGesture { selectedIndex = 2 }
                    .tag(2)
                    .tabItem {
                        Image(systemName: "plus.square")
                            .environment(\.symbolVariants, .none)
                    }
                
                NotificationsView()
                    .onTapGesture { selectedIndex = 3 }
                    .tag(3)
                    .tabItem {
                        Image(systemName: "heart")
                            .environment(\.symbolVariants, .none)
                    }
                
                ProfileView(user: user)
                    .onTapGesture { selectedIndex = 4 }
                    .tag(4)
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                            .environment(\.symbolVariants, .none)
                    }
            }
            .navigationTitle(tabTitle)
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
    
    var tabTitle: String {
        switch selectedIndex {
        case 0: return "Feed"
        case 1: return "Explore"
        case 2: return "New Post"
        case 3: return "Notifications"
        case 4: return "Profile"
        default: return ""
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(selectedIndex: .constant(0), user: User(email: "future@mail.com", username: "future", fullname: "Future PLUTO Hendrix", profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-ec865.appspot.com/o/profile_images%2FF7482075-3043-41BE-8583-9C1181944CF0?alt=media&token=5fd8733f-ad4c-4f15-95d1-bc5c865d1541"))
    }
}
