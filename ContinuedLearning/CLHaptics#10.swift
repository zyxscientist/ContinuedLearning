//
//  CLHaptics#10.swift
//  ContinuedLearning
//
//  Created by PeterZ on 2022/9/20.
//

import SwiftUI

struct CLHaptics_10: View {
    var body: some View {
        VStack(spacing: 30){
            HStack(spacing: 10){
                Button("Error") {
                    HapticManager.instance.notificationHaptic(type: .error)
                }
                
                Button("Success") {
                    HapticManager.instance.notificationHaptic(type: .success)
                }
                
                Button("Warning") {
                    HapticManager.instance.notificationHaptic(type: .warning)
                }
            }
            Divider()
            HStack(spacing: 10){
                Button("Heavy") {
                    HapticManager.instance.impactHaptic(type: .heavy)
                }
                
                Button("Medium") {
                    HapticManager.instance.impactHaptic(type: .medium)
                }
                
                Button("Soft") {
                    HapticManager.instance.impactHaptic(type: .soft)
                }
                
                Button("Rigid") {
                    HapticManager.instance.impactHaptic(type: .rigid)
                }
            }
        }
    }
}

struct CLHaptics_10_Previews: PreviewProvider {
    static var previews: some View {
        CLHaptics_10()
    }
}
