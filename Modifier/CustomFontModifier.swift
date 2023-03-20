//
//  CustomFontModifier.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2023/3/20.
//

import SwiftUI

struct CustomFontModifier: ViewModifier {
    
    var size: CGFloat = 16
    var customFontsStyle : String
    
    func body(content: Content) -> some View {
        content
            .font(.custom(customFontsStyle, size: size))
    }
}
