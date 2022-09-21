//
//  CLLocalNotification.swift
//  ContinuedLearning
//
//  Created by PeterZ on 2022/9/20.
//

import SwiftUI

struct CLLocalNotification: View {
    var body: some View {
        VStack(spacing:8){
            Button("Request Permission") {
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("Time Notification") {
                NotificationManager.instance.timeScheduleNotification()
            }
            
            Button("Calender Notification") {
                NotificationManager.instance.calenderScheduleNotification()
            }
        }
        .onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
            // 让外面的红点（Badge）变为0
        }
    }
}

struct CLLocalNotification_Previews: PreviewProvider {
    static var previews: some View {
        CLLocalNotification()
    }
}
