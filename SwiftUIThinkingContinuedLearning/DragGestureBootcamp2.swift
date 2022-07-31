//
//  DragGestureBootcamp2.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/2.
//

import SwiftUI

struct DragGestureBootcamp2: View {
    
    @State var OffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)).ignoresSafeArea()
            
            BottomView()
                .offset(y: OffsetY) // 底部初始位置
                .offset(y: currentDragOffsetY) // 拖拉位置
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            withAnimation(.spring()){
                                currentDragOffsetY = value.translation.height // y軸的 拖拉量
                            }
                        }
                        .onEnded{ value in

                            withAnimation(.spring()){
                                // y 被拉超過 150  執行
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -OffsetY // 剛好跟初始位置 相對

                                }
                                // endingOffsetY != 0 -> 不等於 0 代表BottomView被拉開

                                else if endingOffsetY != 0 && currentDragOffsetY > 150{
                                    endingOffsetY = 0
                                }
                                
                                currentDragOffsetY = 0 // 結束完一個動作 都將Y軸變化量歸 0
                            }
                        }
                )
            
            Text("\(currentDragOffsetY)")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct DragGestureBootcamp2_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBootcamp2()
    }
}

struct BottomView: View {
    var body: some View {
        VStack(spacing: 20){
            Image(systemName: "chevron.up")
                .foregroundColor(.white)
                .padding()
            
            Text("Sign Up")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("在這裡添加此項目的文件說明 Hellow World Hellow World Hellow World Hellow World Hellow World!Hellow WorldHellow World")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Text("創建新帳號")
                .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)).cornerRadius(15))
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)))
        .cornerRadius(15)
    }
}
