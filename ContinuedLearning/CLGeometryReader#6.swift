//
//  CLGeometryReader#6.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2022/9/19.
//

import SwiftUI

struct CLGeometryReader_6: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .rotation3DEffect(
                                Angle.degrees(getTheDegreeByScrolling(proxy)*40)
                                , axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(width: 300, height: 200)
                    .padding()
                }
            }
        }
    }
    
    func getTheDegreeByScrolling(_ geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        // 获取屏幕宽度一半的值
        
        let currentX = geo.frame(in: .global).midX
        // 获取当前元素中间点在滚动时的坐标
        
        print(currentX)
        return Double ( 1 - (currentX / maxDistance) )
        // 当它们相等，也就是说刚好移动到中轴的时候，恰好返回0
    }
    
}

struct CLGeometryReader_6_Previews: PreviewProvider {
    static var previews: some View {
        CLGeometryReader_6()
    }
}
