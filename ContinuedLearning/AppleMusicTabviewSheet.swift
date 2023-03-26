//
//  AppleMusicTabviewSheet.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2023/3/20.
//

import SwiftUI

struct AppleMusicTabviewSheet: View {
    //动画参数
    @State private var expandSheet: Bool = false
    @Namespace private var animation
    
    var body: some View {
        //Tabview
        TabView {
            SampleTab("Listen NowQ","play.circle.fill")
            SampleTab("Browse", "square.grid.2x2.fill")
            SampleTab("Radio", "dot.radiowaves.left.and.right")
            SampleTab("Music", "play.square.stack")
            SampleTab("Search", "magnifyingglass")
        }
        .tint(.red)
        // 在安全区域范围内布置该元素
        .safeAreaInset(edge: .bottom) {
            // MARK: 这个就是在Tabbar上方放置东西的办法
            if expandSheet {
                ExpandBottomSheet(expandSheet: $expandSheet, animation: animation)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
            } else {
                CustomBottomSheet()
            }
        }
    }
    
    @ViewBuilder
    func CustomBottomSheet() -> some View {
        // 点击后让原有的背景消失
        ZStack {
            if expandSheet {
                Rectangle()
                    .fill(.clear)
            } else {
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .overlay {
                        MusicInfo(expandSheet: $expandSheet, animation: animation)
                    }
                    .matchedGeometryEffect(id: "BGVIEW", in: animation)
            }
        }
        .frame(height: 70)
        // 分割线
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(.gray.opacity(0.2))
                .frame(height: 1)
        }
        // 系统默认的Tabbar 是49
        .offset(y: -49)
    }
}


@ViewBuilder
func SampleTab(_ title: String, _ icon: String) -> some View {
    Text(title)
        .tabItem {
            Image(systemName: icon)
            Text(title)
        }
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(.ultraThickMaterial, for: .tabBar)
}

struct AppleMusicTabviewSheet_Previews: PreviewProvider {
    static var previews: some View {
        AppleMusicTabviewSheet()
            .preferredColorScheme(.dark)
    }
}

struct MusicInfo: View {
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    var body: some View{
        HStack(spacing: 0) {
            // 过渡展开效果
            ZStack{
                if !expandSheet {
                    GeometryReader {
                        let size = $0.size
                        
                        Image("album")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                    }
                    .matchedGeometryEffect(id: "album", in: animation)
                }
            }
            .frame(width: 45, height: 45)
            
            
            Text("Leslie Cheung 張國榮 - The Wind Continues to Blow ")
                .fontWeight(.semibold)
                .font(.system(size: 20))
                .lineLimit(1)
                .padding(.horizontal, 15)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "pause.fill")
                    .font(.title2)
            }
            
            Button {
                
            } label: {
                Image(systemName: "forward.fill")
                    .font(.title2)
            }
            .padding(.leading, 15)
            
        }
        .foregroundColor(.primary)
        .padding(.horizontal)
        .padding(.bottom, 5)
        .frame(height: 70)
        .contentShape(Rectangle()) // 定义操作热区
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)){
                expandSheet = true
            }
        }
    }
}
