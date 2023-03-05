//
//  HapticManager.swift
//  Tars
//
//  Created by Heeji Sohn on 2022/11/23.
//

import UIKit

class HapticManager {
    static let instance = HapticManager()
    
    // type에 따른 haptic feedback
    func hapticNotification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    // style에 따른 haptic feedback
    func hapticImpact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
