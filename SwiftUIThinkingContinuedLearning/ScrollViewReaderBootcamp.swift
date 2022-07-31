//
//  ScrollViewReaderBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/2.
//

import SwiftUI

//FOREACH 給data的話 會有問題

struct ScrollViewReaderBootcamp: View {
    
    @State var scrollToIndex: Int = 0
    @State var textFieldText: String = ""
    
    var name: [String] = [
        "SB" , "DB2"  , "333333", "FOUR" ,"Give me five" ,"66666"
    ]
    
    var body: some View {
        VStack {
            TextField("Enter a # here...", text: $textFieldText)
                .frame(height: 55)
                .padding(.horizontal)
                .border(Color.black)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            // 點下後 動作 :
            // 將 輸入匡的 數字 textFieldText 轉成 Int 再傳給 scrollToIndex
            // .onChange 觀察到 scrollToIndex 有變化 所以開始動作
            // scrollToIndex 傳給 value 再給到 scrollTo裡面的 id位置
            // proxy.scrollTo(value, anchor: .top) -> (id第幾個 , 定點位置)
            Button("點擊  GO TO # 49"){
                withAnimation(.spring()){
                    
                    // 輸入匡型態是 Str 要轉成Int
                    // 輸入匡可能是空的(nil?)
                    if let index = Int(textFieldText){
                        scrollToIndex = index
                    } 
                }
            }
            
            ScrollView(.horizontal){
                ScrollViewReader{ proxy in

                        HStack {
                            ForEach(0..<50 ,id: \.self){ index in

                                Text("This is item # \(index)")
                                .font(.headline)
                                .frame(height: 200)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 10)
                                .padding()
                                .id(index) // 給scrollTo 判斷用
    //                    // 使用 要記得給 項目.id() 才能判別
    //                    proxy.scrollTo(49, anchor: .top) // (id第幾個 , 定點位置)
                        
                        }
                        // 觀察一個值 如果有變化 則動作
                        // scrollToIndex -> Int
                        // value 綁定 scrollToIndex
                        .onChange(of: scrollToIndex, perform: { value in
                            withAnimation(.spring()){
                                proxy.scrollTo(value, anchor: .top)
                            }
                    })
                        }
                }
            }
        }
    }
}

struct ScrollViewReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderBootcamp()
    }
}
