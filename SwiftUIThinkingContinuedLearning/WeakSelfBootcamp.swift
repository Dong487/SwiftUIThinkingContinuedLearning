//
//  WeakSelfBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/17.
//

// [weak self] +強

import SwiftUI

struct WeakSelfBootcamp: View {
    
    @AppStorage("count") var count: Int? // 暫存'
    
    init(){
        count = 0
    }
    
    var body: some View {
        NavigationView{
            NavigationLink("Navigate", destination: WeakSelfSecondScreen())
            
                .navigationTitle("Screen 1")
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green)
                .cornerRadius(15)
            ,alignment: .topTrailing
        )
    }
}

struct WeakSelfSecondScreen: View{
    
    @StateObject var vm = WeakSelfSecondScreenViewModel()
    
    var body: some View{
        VStack {
            Text("Second View")
                .font(.largeTitle)
                .foregroundColor(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
            
            // 假設 vm.data有東西    show data (預設為nil)
            if let data = vm.data{
                Text(data)
            }
        }
    }
}

class WeakSelfSecondScreenViewModel: ObservableObject{
    
    @Published var data : String? = nil
    
    init(){
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        print("初始化 NOW")

        getData()
    }
    
    deinit {
       
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
        print("DEINIT初始化 NOW \(currentCount)")
    }
    
    
    func getData(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.data = "NEW DATA!!!!"
        }
    }
}

struct WeakSelfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelfBootcamp()
    }
}
