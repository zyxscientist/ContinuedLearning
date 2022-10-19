//
//  CLTimerAndonReceive.swift
//  ContinuedLearning
//
//  Created by PeterZ on 2022/10/18.
//

import SwiftUI

struct CLTimerAndonReceive: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .default).autoconnect()
    
    @State var currentDate: Date = Date()
    
    // 系统提供的一个简便的格式化器
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        // formatter.dateStyle = .medium
        formatter.dateFormat = "hh:mm:ss"
        formatter.timeZone = TimeZone(identifier:"Asia/Chongqing")
        return formatter
    }
    
    
    
    
    var body: some View {
        ZStack{
            RadialGradient(colors: [Color.pink, Color.blue],
                           center: .center,
                           startRadius: 5,
                           endRadius: 500)
            .ignoresSafeArea()
            
            Text(dateFormatter.string(from: currentDate))
                .foregroundColor(.white)
                .font(.system(size: 100, weight: .bold, design: .monospaced))
                .lineLimit(1)
                .padding()
                // 保证它总是一行显示完毕
                .minimumScaleFactor(0.1)
        }
        .onReceive(timer, perform: { value in
            currentDate = value
        })
    }
}

struct CLTimerAndonReceive_Previews: PreviewProvider {
    static var previews: some View {
        CLTimerAndonReceive()
    }
}
