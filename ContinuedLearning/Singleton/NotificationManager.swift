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
    
    func requestAuthorization(){
        let notificationOption: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: notificationOption) { success, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("success")
            }
        }
    }
    
    // 本地 trigger 种类：
    // time :触发后几秒之后发送通知
    // calender :控制年月日、时分秒发送通知
    // locaiton
    
    
    // Time
    // 触发后几秒之后发送通知
    func timeScheduleNotification() {
        
        // 内容部分
        let content = UNMutableNotificationContent()
        content.sound = .default
        content.badge = 1
        content.title = "This is the title"
        content.body = "This is the body"
        content.subtitle = "This is the subtitle"
        
        // Trigger
        let triggerTime = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: triggerTime
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    // Calender
    // 控制年月日、时分秒发送通知
    func calenderScheduleNotification() {
        
        // 内容部分
        let content = UNMutableNotificationContent()
        content.sound = .default
        content.badge = 1
        content.title = "This is the title"
        content.body = "This is the body"
        content.subtitle = "This is the subtitle"
        
        // Trigger
        var dateComponents = DateComponents()
        dateComponents.hour = 21
        dateComponents.minute = 48
        // dateComponents 还有很多后缀可以跟的
        let triggerTime = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: triggerTime
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
}
