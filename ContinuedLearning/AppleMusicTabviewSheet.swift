//
//  AppleMusicTabviewSheet.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2023/3/20.
//

import SwiftUI

struct AppleMusicTabviewSheet: View {
    var body: some View {
        //Tabview
        TabView {
            SampleTab("Listen Now","play.circle.fill")
            SampleTab("Browse", "square.grid.2x2.fill")
            SampleTab("Radio", "dot.radiowaves.left.and.right")
            SampleTab("Music", "play.square.stack")
            SampleTab("Search", "magnifyingglass")
        }
        .tint(.red)
        .modifier(CustomFontModifier(size: 20, customFontsStyle: "PlusJakartaSansRoman-Medium"))
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
