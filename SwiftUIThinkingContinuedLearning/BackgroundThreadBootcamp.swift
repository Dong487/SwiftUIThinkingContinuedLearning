//
//  BackgroundThreadBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/17.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject{
    
    @Published var dataArray: [String] = []
    
    
    // 有關螢幕的 UI 必須用主線程
    // 先在後線程 獲取 data
    // 再傳到主線程 給 螢幕顯示
    func fetchData(){
        
        // 在背景線程 run 獲取data
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            // 檢查使用的線程
            print("檢查 1: \(Thread.isMainThread)")
            print("檢查 1: \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray = newData
            
                // 檢查使用的線程
                print("檢查 2: \(Thread.isMainThread)")
                print("檢查 2: \(Thread.current)")
            }
        }
    }
    
    private func downloadData() -> [String]{
        var data: [String] = []
        
        for x in 0..<100{
            data.append("\(x)")
            print(data)
        }
        return data
    }
    
}

struct BackgroundThreadBootcamp: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        
        ScrollView{
            LazyVStack(spacing: 10){
                Text("Load Data")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self){ item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BackgroundThreadBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadBootcamp()
    }
}
