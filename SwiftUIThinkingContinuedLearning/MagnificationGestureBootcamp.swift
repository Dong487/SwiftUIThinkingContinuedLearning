//
//  MagnificationGesture.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/9/26.
//

import SwiftUI

struct MagnificationGestureBootcamp: View {
    
    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    
    var body: some View {
        
        VStack(spacing: 10){
            
            HStack{
                Circle()
                    .frame(width: 35, height: 35)
                Text("SwiftUI Thinking")
                
                Spacer()
                
                Image(systemName: "3213132")
                
            }
            .padding(.horizontal)
            
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        
                        // 2指點擊放大
                        .onChanged{ value in
                            currentAmount = value - 1
                        }
                        // 放手後
                        .onEnded{ value in
                            withAnimation(.spring()){
                                currentAmount = 0
                            }
                        }
                )
            
            HStack{
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                
                Spacer()
                
            }
            .padding(.horizontal)
            .font(.headline)
            
            Text("照片照片照片！")
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal)
        }
        
        
//        VStack {
//            Text("\(currentAmount)")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//
//            Spacer()
//
//            Text("Hello, World!")
//                .font(.title)
//                .padding(40)
//                .background(Color.pink.cornerRadius(10))
//                .scaleEffect(1 + currentAmount + lastAmount)
//                .gesture(
//                    MagnificationGesture()
//                        .onChanged { value in
//                            currentAmount = value - 1
//
//                        }
//                        .onEnded{ value in
//
//                            lastAmount += currentAmount
//                            currentAmount = 0
//                        }
//            )
//
//            Spacer()
//        }
        
    }
}

struct MagnificationGesture_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureBootcamp()
    }
}
