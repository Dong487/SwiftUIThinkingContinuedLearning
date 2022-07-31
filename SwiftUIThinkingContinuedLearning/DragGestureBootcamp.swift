//
//  DragGestureBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/1.
//

import SwiftUI

struct DragGestureBootcamp: View {
    
    @State var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            
            VStack{
                Text("\(offset.width)")
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: 300, height: 500)
                .offset(offset)
                .rotationEffect(Angle(degrees: getRotationAmount()))
                .scaleEffect(getScaleAmount())
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            withAnimation(.spring()){
                                offset = value.translation
                            }
                        }
                        .onEnded{ value in
                            withAnimation(.spring()){
                                offset = .zero
                            }
                        }
            )
        }
    }
    
    // 縮放大小用 -> 回傳一個CGFloat
    func getScaleAmount() -> CGFloat{
        
        let max = UIScreen.main.bounds.width / 2 // 螢幕最大寬度 / 2
        let currentAmount = abs(offset.width) // 絕對值(offset的 x 變化量)
        let percentage = currentAmount / max
        
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    // 旋轉角度用 -> 回傳一個 Double 給 Angle(degrees: Double)
    func getRotationAmount() -> Double {
        
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / max
        
        let percentageAsDouble = Double(percentage) // 轉成 Double 型態
        let maxAngle: Double = 10
        
        return percentageAsDouble * maxAngle
    }
}

struct DragGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBootcamp()
    }
}
