//
//  MultipleSheetsBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/3.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}


// 1 - use a binding -> 適合只有一項動態要追蹤 Model中有其他靜態的較不適合
// 2 - use multiple .sheets -> 在同一層中 分別加上.sheet 以及 Bool判斷
// 3 - use $item

struct MultipleSheetsBootcamp: View {
    
    @State var selectedModel: RandomModel? = nil
  //  @State var showSheet: Bool = false
    
    var body: some View {
        
        ScrollView{
            VStack(spacing: 20){
                
                ForEach(0..<50){ index in
                    Button("我是按鈕\(index)"){
                        selectedModel = RandomModel(title: "\(index)")
                      //  showSheet.toggle()
                    }
                }
            }
            .sheet(item: $selectedModel) { model in
                NextScreen(selectedModel: model)
            }
        }

        
        
//        .sheet(isPresented: $showSheet, content: {
//            NextScreen(selectedModel: $selectedModel)
//        })
    }
}


struct NextScreen: View {
    
    let selectedModel: RandomModel
    
    var body: some View{
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}


struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp()
    }
}
