//
//  CLLongPress#1.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2022/9/15.
//

import SwiftUI

struct CLLongPress_1: View {
    
    @State var compelete: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(height: 36)
                .foregroundColor(Color.blue)
                .frame(maxWidth: 20)
                .frame(maxWidth: .infinity,alignment: .leading)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 30.0, style: .continuous))
                .padding(.horizontal)
            
            Text("LongPressed")
                .font(.system(size: 28, design: .rounded))
                .fontWeight(.bold)
                .padding(.all)
                .foregroundColor(.white)
                .background(compelete ? Color.blue : Color.black )
                .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
        }
    }
}

struct CLLongPress_1_Previews: PreviewProvider {
    static var previews: some View {
        CLLongPress_1()
    }
}
