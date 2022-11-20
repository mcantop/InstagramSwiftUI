//
//  NotificationsViewModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 19/11/2022.
//

import Foundation

final class NotificationsViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    
    init() {
        fetchUserNotifications()
    }
    
    func fetchUserNotifications() {
        NotificationService.fetchUserNotifications { notifications in
            self.notifications = notifications
        }
    }
}
