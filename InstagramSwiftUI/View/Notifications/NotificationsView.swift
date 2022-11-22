//
//  NotificationsView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI

struct NotificationsView: View {
    @ObservedObject var viewModel = NotificationsViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.notifications) { notification in
                        NotificationCell(viewModel: NotificationCellViewModel(notification: notification))
                    }
                }
            }
            .refreshable {
                viewModel.fetchUserNotifications()
            }
            
            // MARK: - Navigation & Tab bar is sometimes transparent, so I make sure that there is always background behind those elements.
            VStack {
                Rectangle()
                    .fill(Color("BackgroundColor"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 90)
                    .edgesIgnoringSafeArea(.top)
                
                Spacer()
            }
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
