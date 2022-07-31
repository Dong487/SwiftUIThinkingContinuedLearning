//
//  LongPressGestureBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/9/25.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        
        VStack{
            
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack{
                
                Text("點擊按鈕")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(15)
                    .onLongPressGesture(minimumDuration: 2.0, maximumDistance: 50){ (isPressing) in
                        // 點擊 的 持續時間內動作 (minimumDuration: 1.0)
                        // 開始點擊 -> 最小持續時間 前
                        if isPressing {
                            // duration 跟 minimumDuration 設一樣的秒數 動畫呈現 會是 按壓填滿
                            withAnimation(.easeInOut(duration: 2.0)){
                                isComplete = true
                            }
                        } else {
                            if isSuccess {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                                    withAnimation(.easeInOut){
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    } perform: {
                        // 達成 按住持續時間 完 才動作
                        withAnimation(.easeInOut){
                            isSuccess = true
                        }
                    }
                
                Text("重置")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(15)
                    .onTapGesture {
                        isSuccess = false
                        isComplete = false
                    }
            }
        }
        
//        Text(isComplete ? "Completed" : "Not Complete")
//            .padding()
//            .padding(.horizontal)
//            .background(isComplete ? Color.green : Color.gray)
//            .cornerRadius(20)
////            .onTapGesture {
////                isComplete.toggle() // 點擊一下就動作
////            }
//
//            // minimumDuration: (按壓持續時間(秒)) -> 時間達成後 動作
//            // maximumDistance: 按住後 能移動的距離  -> 超出範圍後 會停止動作
//            .onLongPressGesture(minimumDuration: 2.0 ,maximumDistance: 50){
//                isComplete.toggle()
//            }
    }
}

struct LongPressGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureBootcamp()
    }
}
