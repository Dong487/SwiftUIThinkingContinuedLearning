//
//  CodableBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/18.
//

import SwiftUI

// Codable = Decodable + Encodable

struct CustomerModel: Identifiable, Codable{
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
    // 實際解碼編碼的 過程
//    enum CodingKeys:String,CodingKey {
//        case id
//        case name
//        case points
//        case isPremium
//    }
//
//    init(id: String ,name: String ,points: Int ,isPremium: Bool){
//        self.id = id
//        self.name = name
//        self.points = points
//        self.isPremium = isPremium
//    }
//
//    // 解碼 Decoder
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//
//    // 編碼 Encoder
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(points, forKey: .points)
//        try container.encode(isPremium, forKey: .isPremium)
//    }
}

class CodableViewModel: ObservableObject{
    
    @Published var customer: CustomerModel? = nil
    
    init(){
        getData()
    }
    
    func getData(){
        
        guard let data = getJsonData() else { return }
        self.customer = try? JSONDecoder().decode(CustomerModel.self, from: data)
//        do{
//            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
//        } catch let error{
//            print("Error Decoding 解碼錯誤 \(error)")
//        }
        
        
//        // JSON解碼  手動暴力解碼
//        if
//            let localData = try? JSONSerialization.jsonObject(with: data, options: []),
//            let dictionary = localData as? [String: Any],
//
//            let id = dictionary["id"] as? String,
//            let name = dictionary["name"] as? String,
//            let points = dictionary["points"] as? Int,
//            let isPremium = dictionary["isPremium"] as? Bool{
//
//            let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
//            customer = newCustomer
//        }
    }
    // Data? ： 有可能沒獲取到data 則為nil
    func getJsonData() -> Data?{
        
        let customer = CustomerModel(id: "000000", name: "DDDDD", points: 77, isPremium: false)
        let jsonData = try? JSONEncoder().encode(customer)
        
//        let dictionary: [String : Any] = [
//            "id" : "3213213",
//            "name" : "LINNN",
//            "points" : 5,
//            "isPremium" : true
//        ]
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        return jsonData
    }
}

struct CodableBootcamp: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 20){
            // 假如不是空的
            if let customer = vm.customer{
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description) // 原本為布林值  description用來描述狀態
            }
        }
    }
}

struct CodableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CodableBootcamp()
    }
}
