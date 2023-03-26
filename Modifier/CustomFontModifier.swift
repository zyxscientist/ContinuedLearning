//
//  CustomFontModifier.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2023/3/20.
//

import SwiftUI

struct CustomFontModifier: ViewModifier {
    
    var size: CGFloat = 16
    var font: CustomFont
    
    enum CustomFont: String {
        case regular = "PlusJakartaSans-Regular"
        case medium = "PlusJakartaSansRoman-Medium"
        case semibold = "PlusJakartaSansRoman-SemiBold"
        // Add more cases for other font styles if needed
    }
    
    
    func body(content: Content) -> some View {
        content.font(.custom(font.rawValue, size: size))
    }
}
