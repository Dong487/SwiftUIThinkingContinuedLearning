//
//  HashableBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/4.
//

import SwiftUI
// Identifiable 為每個Model建立ID
struct MyCustomModel : Identifiable{
    let id = UUID().uuidString
    let title: String
    let subtitle: String
}

// Hashable 為 title建立 ID
struct MyCustomModel1 : Hashable{
    
    let title: String
    let subtitle: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title + subtitle)
    }
}

struct HashableBootcamp: View {
    
    // String 符合 Hashable   且為每個字串建立一個唯一的ID
    let data : [MyCustomModel1] = [
        MyCustomModel1(title: "ONE", subtitle: "1111"),
        MyCustomModel1(title: "Two", subtitle: "2222"),
        MyCustomModel1(title: "Three", subtitle: "3333"),
        MyCustomModel1(title: "FOUR", subtitle: "44444"),
        MyCustomModel1(title: "FIVE", subtitle: "555555"),
    ]
    
    var body: some View {
        ScrollView{
            VStack(spacing: 40){
                
                // String 符合 Hashable 協議
                // 且為每個字串建立一個唯一的隨機ID -> hashValue
                ForEach(data ,id: \.self){ item in
                    VStack {
                        Text(item.title)
                            .font(.headline)
                        Text("hashValue:\(item.hashValue.description)")
                            .font(.caption)
                            .foregroundColor(.red)
                        Text(item.subtitle)
                            .font(.headline)
                        Text("hashValue:\(item.hashValue.description)")
                            .font(.caption)
                            .foregroundColor(.yellow)
                    }
                }

            }
        }
    }
}

struct HashableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HashableBootcamp()
    }
}
