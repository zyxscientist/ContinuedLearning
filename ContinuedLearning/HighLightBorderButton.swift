//
//  HighLightBorderButton.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2022/11/14.
//

import SwiftUI

struct HighLightBorderButton: View {
    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .inset(by: 1)
                .fill(.black)
                
            Text("Buy")
                .font(.title)
        }
        .frame(width: 200, height: 100)
        .background(
            AngularGradient(
                gradient: Gradient(colors: [.blue.opacity(0), .blue, .blue.opacity(0)]),
                center: .center)
        )
        .containerShape(
            RoundedRectangle(cornerRadius: 30.0, style: .continuous)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .stroke(.white.opacity(0.2), lineWidth: 1)
            )
        }
    }
    

struct HighLightBorderButton_Previews: PreviewProvider {
    static var previews: some View {
        HighLightBorderButton()
    }
}
