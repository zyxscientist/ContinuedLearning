//
//  NotificationManager.swift
//  ContinuedLearning
//
//  Created by PeterZ on 2022/9/20.
//

import SwiftUI
import UserNotifications

class NotificationManager{
    
    static let instance = NotificationManager() // Singleton
    
    func  requestAuthorization(){
        let notificationOption: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: notificationOption) { success, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("success")
            }
        }
    }
    
}
