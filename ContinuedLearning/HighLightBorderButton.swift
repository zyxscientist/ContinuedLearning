//
//  HighLightBorderButton.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2022/11/14.
//

import SwiftUI

struct HighLightBorderButton: View {
    
    @State private var isRotated = false
    
    var body: some View {
        
        
        VStack(spacing: 30) {
            // Button 1
            ZStack {
                ContainerRelativeShape()
                    .inset(by: 1.5)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("top"), Color("buttom")]), startPoint: .top, endPoint: .bottom))
                    .opacity(1)
                
                    // 高光边缘
                    .background(
                        AngularGradient(
                            gradient: Gradient(
                                colors:
                                    [
                                        Color("highlight").opacity(0),
                                        Color("highlight").opacity(0.3),
                                        Color("highlight").opacity(1)
                                    ]),
                            center: .center,
                            angle: Angle(degrees: isRotated ? 360 : 0)
                        )
                        // 关键点在这
                        .clipShape(
                            RoundedRectangle(cornerRadius: 30.0, style: .continuous)
                        )
                        .rotationEffect(Angle(degrees: 0))
                    )
                    .frame(width: 200, height: 75)
                Text("Button")
                    .font(.system(size: 24, weight: .regular, design: .monospaced))
            }
            .containerShape(
                RoundedRectangle(cornerRadius: 30.0, style: .continuous)
            )
            
            // Button 2
            ZStack {
                ContainerRelativeShape()
                    .inset(by: 1.5)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("top"), Color("buttom")]), startPoint: .top, endPoint: .bottom))
                    .opacity(1)
                
                // 高光边缘
                    .background(
                        AngularGradient(
                            gradient: Gradient(
                                colors:
                                    [Color("highlight").opacity(0),
                                     Color("highlight").opacity(0.3),
                                     Color("highlight").opacity(1)
                                    ]),
                            center: .center,
                            angle: Angle(degrees: isRotated ? 360 : 0)
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 100.0, style: .continuous)
                        )
                        .rotationEffect(Angle(degrees: 0))
                    )
                    .frame(width: 200, height: 75)
                Text("Button")
                    .font(.system(size: 24, weight: .regular, design: .monospaced))
            }
            .containerShape(
                RoundedRectangle(cornerRadius: 100.0, style: .continuous)
            )
            
            HStack(spacing: 40) {
                ZStack {
                    ContainerRelativeShape()
                        .inset(by: 1.5)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color("top"), Color("buttom")]), startPoint: .top, endPoint: .bottom))
                        .opacity(1)
                    // 高光边缘
                        .background(
                            AngularGradient(
                                gradient: Gradient(colors: [.red.opacity(0), .red.opacity(0), .red.opacity(0.5), .yellow, .green, .blue, .purple, .red.opacity(1)]),
                                center: .center,
                                angle: Angle(degrees: isRotated ? 360 : 0)
                            )
                            .clipShape(
                                RoundedRectangle(cornerRadius: 50, style: .continuous)
                            )
                            
                        )
                        .frame(width: 75, height: 75)
                    Text("ON")
                        .font(.system(size: 24, weight: .regular, design: .monospaced))
                }
                .containerShape(
                    RoundedRectangle(cornerRadius: 50, style: .continuous)
                )
                
                // Button #4
                ZStack {
                    ContainerRelativeShape()
                        .inset(by: 1.5)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color("top"), Color("buttom")]), startPoint: .top, endPoint: .bottom))
                        .opacity(1)
                    // 高光边缘
                        .background(
                            AngularGradient(
                                gradient: Gradient(colors: [.red.opacity(0), .red.opacity(0), .red.opacity(0.5), .yellow, .green, .blue, .purple, .red.opacity(1)]),
                                center: .center,
                                angle: Angle(degrees: isRotated ? 360 : 0)
                            )
                            .clipShape(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                            )
                            .rotationEffect(Angle(degrees: 0))
                        )
                        .frame(width: 75, height: 75)
                    Text("OFF")
                        .font(.system(size: 24, weight: .regular, design: .monospaced))
                }
                .containerShape(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                )
            }
        }
        .onAppear(perform: loopingAnimation)
        
    }
    
    // 动画函数
    func loopingAnimation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(
                Animation
                    .linear(duration: 3.0)
                    .repeatForever(autoreverses: false)
            ) {
                isRotated.toggle()
                }
            }
        }
    }


struct HighLightBorderButton_Previews: PreviewProvider {
    static var previews: some View {
        HighLightBorderButton().preferredColorScheme(.dark)
    }
}
