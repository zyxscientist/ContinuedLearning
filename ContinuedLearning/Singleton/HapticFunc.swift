//
//  HapticFunc.swift
//  ContinuedLearning
//
//  Created by PeterZ on 2022/9/20.
//

import SwiftUI

class HapticManager {
    
    static let instance = HapticManager()
    
    func notificationHaptic(type: UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impactHaptic(type: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: type)
        generator.impactOccurred()
    }
    
}
