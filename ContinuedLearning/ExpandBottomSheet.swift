//
//  ExpandBottomSheet.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2023/3/26.
//

import SwiftUI

struct ExpandBottomSheet: View {
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    // 视图参数
    @State private var animateContent: Bool = false
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            ZStack{
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .overlay(content: {
                        Rectangle()
                            .fill(Color("BG"))
                            .opacity(animateContent ? 1 : 0)
                    })
                    .overlay(alignment: .top) {
                        MusicInfo(expandSheet: $expandSheet, animation: animation)
                            .allowsHitTesting(false)
                            .opacity(animateContent ? 0 : 1)
                    }
                    .matchedGeometryEffect(id: "BGVIEW", in: animation)
                
                VStack(spacing: 15) {
                    // Grab Indicator
                    Capsule()
                        .fill(.gray)
                        .frame(maxWidth: 40, maxHeight: 5)
                        .opacity(animateContent ? 1 : 0)
                        .padding(.top, 15)
                    
                    // 专辑大图
                    GeometryReader {
                        // 一个 GeometryReader 很方便的用法，获取父视图的宽高
                        let size = $0.size
                        Image("album")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    }
                    .matchedGeometryEffect(id: "album", in: animation)
                    // 因为边距是25，所以高度减50正好得到一个正方面
                    .frame(height: size.width - 50)
                }
                // 适配旧机器
                .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                .padding(.horizontal, 25)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)){
                        expandSheet = false
                        animateContent = false
                    }
                }
            }.ignoresSafeArea(.container, edges: .all)
        }
        .onAppear{
            withAnimation(.easeInOut(duration: 0.35)){
                // MARK: 这样不太好，所有动画都绑一块了
                animateContent  = true
            }
        }
    }
}

struct ExpandBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        // 就挺骚的，换成这个
        AppleMusicTabviewSheet()
            .preferredColorScheme(.dark)
    }
}
