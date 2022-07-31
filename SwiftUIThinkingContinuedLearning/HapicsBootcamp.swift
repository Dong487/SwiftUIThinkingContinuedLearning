//
//  HapicsBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/4.
//

import SwiftUI

class HapicManager{
    
    static let instance = HapicManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}


struct HapicsBootcamp: View {
    var body: some View {
        VStack(spacing: 20){
            
            Button("成功震動") {
                HapicManager.instance.notification(type: .success)
            }
            Button("警告震動") {
                HapicManager.instance.notification(type: .warning)
            }
            Button("錯誤震動") {
                HapicManager.instance.notification(type: .error)
            }
            Divider()
            
            Button("soft"){
                HapicManager.instance.impact(style: .soft)
            }
            Button("rigid"){
                HapicManager.instance.impact(style: .rigid)
            }
            Button("medium"){
                HapicManager.instance.impact(style: .medium)
            }
            Button("light"){
                HapicManager.instance.impact(style: .light)
            }
            Button("heavy"){
                HapicManager.instance.impact(style: .heavy)
            }
        }
    }
}

struct HapicsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HapicsBootcamp()
    }
}
