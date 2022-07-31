//
//  MaskBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/3.
//

import SwiftUI

struct MaskBootcamp: View {
    
    @State var rating: Int = 4
    
    var body: some View {
        ZStack{
            starView    // 實際被點擊 改變 rating的 View
                .overlay(
                    overlayView
                        .mask(starView) // 在starView底下
                                        // 使用 .mask最大差異在 可以使用漸層顏色
                )
        }
    }
    private var overlayView: some View{
        GeometryReader{ geometry in
            ZStack(alignment: .leading){
                Rectangle()
                    .foregroundColor(.yellow)  // 可以改成漸層顏色 -> .fill(LinearGradient)
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false) // 禁止這層被點擊
    }
    
    
    private var starView: some View{
        HStack{
            
            ForEach(1..<6) { index in
                
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(rating >= index ? Color.yellow : Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            rating = index
                        }
                    }
            }
        }
    }
}

struct MaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MaskBootcamp()
    }
}
