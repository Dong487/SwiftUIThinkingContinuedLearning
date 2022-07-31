//
//  ArraysBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/4.
//

import SwiftUI

struct UserModel: Identifiable{
    let id = UUID().uuidString
    let name : String?
    let points: Int
    let isVerified: Bool // 以驗證
}
// ArrayModification 數組修改
// ObservableObject 被觀察  (用 @StateObject 觀察)
class ArrayModificationViewModel: ObservableObject{
    
    @Published var dataArray: [UserModel] = []
    // 條件篩選
    @Published var filteredArray: [UserModel] = []
    // 提出 UserModel 裡面的某一項
    @Published var mappedArray: [String] = []
    
    // 初始化
    init(){
        // 執行這個 func
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray(){
        // 1) Sort
        // 2) Filter
        // 3) map
        
        
        // Sort -> dataArray 互相比較 points大小 > 越大排越前面
        /*
            filteredArray = dataArray.sorted(by: { $0.points > $1.points})
        */
        
        // Filter -> 自定篩選的條件 從 dataArray 挑選出來
        /*
    // Ex: !$0.isVerified -> isVerified = false 的 user
    // Ex: $0.name.contains("G") = dataArray.name 中 有出現(包含)"G"
    filteredArray = dataArray.filter({ $0.name.contains("G") })
        */

        // map
        /*
        // mappedArray = dataArray.map({ $0.name })
        
//          mappedArray = dataArray.map({ (user) -> String in
//              return user.name ?? "ERROR"
//          })    // 如果字串有空的(nil) 則回傳  "ERROR"到字串內

        mappedArray = dataArray.compactMap({ $0.name }) // 直接忽略掉 空的字串(nil)
 */
        
        mappedArray = dataArray
                        .sorted(by: { $0.points > $1.points}) // points 多的排前面
                        .filter( { $0.isVerified}) // 有通過驗證的才挑選出來
                        .compactMap({$0.name})  // 顯示名字
    }
 
    
    // 取得用戶者資料
    func getUsers(){
        // 宣告假資料
        let user1 = UserModel(name: "DONG", points: 99, isVerified: true)
        let user2 = UserModel(name: "SHENG", points: 31, isVerified: true)
        let user3 = UserModel(name: "Q_Q", points: 35, isVerified: true)
        let user4 = UserModel(name: "T_T", points: 27, isVerified: true)
        let user5 = UserModel(name: nil, points: 4, isVerified: false)
        let user6 = UserModel(name: nil, points: 1, isVerified: true)
        let user7 = UserModel(name: "CHEN", points: 0, isVerified: true)
        let user8 = UserModel(name: "LIN", points: 53, isVerified: false)
        let user9 = UserModel(name: "Ze", points: 26, isVerified: false)
        let user10 = UserModel(name: "WU", points: 10, isVerified: true)
        // 添加到 dataArray
        self.dataArray.append(contentsOf: [
            user1,user2,user3,user4,user5,
            user6,user7,user8,user9,user10,
        ])
    }
}

struct ArraysBootcamp: View {
    // 觀察 ArrayModificationViewModel 這個 vm
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                ForEach(vm.mappedArray, id: \.self){ name in
                    Text(name)
                        .font(.largeTitle)
                }
                
//                ForEach(vm.filteredArray){ user in
//                    VStack(alignment: .leading){
//                        Text(user.name)
//                            .font(.headline)
//
//                        HStack{
//                            Text("Points: \(user.points)")
//
//                            Spacer()
//
//                            if user.isVerified{
//                                Image(systemName: "flame.fill")
//                                    .foregroundColor(.yellow)
//                            }
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
//                    .cornerRadius(15)
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

struct ArraysBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootcamp()
    }
}
