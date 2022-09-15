//
//  CLLongPress#1.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2022/9/15.
//

import SwiftUI

struct CLLongPress_1: View {
    
    @State var isPressing: Bool = false
    @State var isComplete: Bool = false
    
    
    var body: some View {
        VStack(spacing: 20) {
            // 先写一个进度条
            Rectangle()
                .frame(height: 36)
                .foregroundColor(isComplete ? Color.green : Color.blue)
                .frame(maxWidth: isPressing ? .infinity: 0)
                .frame(maxWidth: .infinity,alignment: .leading)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 30.0, style: .continuous))
                .padding(.horizontal)
            
            
            Text("LongPressed")
                .font(.system(size: 28, design: .rounded))
                .fontWeight(.bold)
                .padding(.all)
                .foregroundColor(.white)
                .background(Color.pink)
                .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                // 用的是新api ↓
                .onLongPressGesture(minimumDuration: 2, maximumDistance: 50) {
                    withAnimation(.easeOut){
                        isComplete = true
                    }
                } onPressingChanged: { isPressing in
                    if isPressing {
                        withAnimation(.easeInOut(duration: 2)){
                            self.isPressing = true
                        }
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                            // 相对上面的执行要延后一点，不然会出现很奇怪的冲突现象
                            if !isComplete {
                                withAnimation(.easeInOut){
                                    self.isPressing = false
                                }
                            }
                        }
                    }
                }
            
            Text("Reset")
                .foregroundColor(.blue)
                .onTapGesture {
                    isPressing = false
                    isComplete = false
                }
        }
    }
    
    struct CLLongPress_1_Previews: PreviewProvider {
        static var previews: some View {
            CLLongPress_1()
        }
    }
}
