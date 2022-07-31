//
//  CoreDataBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/5.
//

import SwiftUI
import CoreData

// View - UI
// Model - data point
// ViewModel - manages the data for view


// ObservableObject 被觀察著
class CoreDataViewModel: ObservableObject{
    
    let container: NSPersistentContainer
    
    @Published var savedEntities: [FruitEntity] = []
    
    init(){
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error{
                print("下載CoreData 發生錯誤 \(error)") // 失敗的話
            }
        }
        fetchFruits()
    }
    
    func fetchFruits(){
        // 讀取要求
        
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do{
            savedEntities = try container.viewContext.fetch(request)
        } catch let error{

            print("ERROR fetching. \(error)")
        }
    }
    
    func addFruit(text: String){
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        // 添加完 儲存
        saveData()
    }
    // 追蹤 ForEach被點擊時 啟動update
    func updateFruit(entity: FruitEntity){
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        
        saveData()
    }
    
    
    func deleteFruit(indexSet: IndexSet){
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index] // 有偏移量的那一個項目
        container.viewContext.delete(entity) // 刪除
        
        saveData() // 儲存
    }
    
    func saveData(){
        do{
            try container.viewContext.save()
            // 儲存完 讀取CoreData
            fetchFruits()
        } catch {
            print("ERROR SAVING. \(error)")
        }
    }
}

struct CoreDataBootcamp: View {
    // StateObject觀察著  CoreDataViewModel
    @StateObject var vm = CoreDataViewModel()
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                TextField("新增你的水果...", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)))
                    .cornerRadius(25)
                    .padding(.horizontal)
                
                Button(action: {
                    // textFieldText 不是空的 執行addFruit     else { return }
                    guard !textFieldText.isEmpty else { return}
                    vm.addFruit(text: textFieldText)
                    // 添加水果儲存完後 清空
                    textFieldText = ""
                }, label: {
                    Text("Button")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)))
                        .cornerRadius(15)
                })
                .padding(.horizontal)
                
                List{
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.name ?? "NO NAME")
                            .onTapGesture {
                                vm.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp()
    }
}
