//
//  CoreDataRelationshipsBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/7.
//

// 沒清除之前的 複寫過去 而是創建一個新的 entity 項目
// #16 時間軸 1:03:15

import SwiftUI
import CoreData

// 3 entities
// BusinessEntity 公司
// DepartmentEntity 部門
// EmployeeEntity 員工


class CoreDataManager{
    
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init(){
        container = NSPersistentContainer(name: "CoreDataContainer") // 要跟你的檔案名稱相同
        container.loadPersistentStores { ( description, error ) in
            if let error = error {
                print("ERROR loading CoreData. \(error)")
            }
        }
        context = container.viewContext
    }
    
    // 儲存
    func save(){
        do{
            try context.save()
            print("Saved 成功！")
        } catch let error{
            print("ERROR SAVING CoreData. \(error.localizedDescription)")
        }
    }
}


// ObservableObject 被觀察著
class CoreDataRelationshipsViewModel: ObservableObject{
    
    let manager = CoreDataManager.instance
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init(){
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func getBusinesses(){
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        // 排序
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true) //  keyPath 路徑。   ascending 升序
        request.sortDescriptors = [sort]
        
        // name 條件篩選過濾 (Apple)
        let filter = NSPredicate(format: "name == %@", "Apple")
        request.predicate = filter
        
        do{
            businesses = try manager.context.fetch(request)
        } catch let error{
            print("ERROR fetching (businesses). \(error.localizedDescription)")
        }
        
    }
    
    func getDepartments(){
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        
        do{
            departments = try manager.context.fetch(request)
        } catch let error{
            print("ERROR fetching (departnments). \(error.localizedDescription)")
        }
    }
    
    func getEmployees(){
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        do{
            employees = try manager.context.fetch(request)
        } catch let error{
            print("ERROR fetching (employees). \(error.localizedDescription)")
        }
    }
    
    func getEmployees(forBusiness business: BusinessEntity){
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        let filter = NSPredicate(format: "business == %@", business)
        request.predicate = filter
        
        do{
            employees = try manager.context.fetch(request)
        } catch let error{
            print("ERROR fetching (employees). \(error.localizedDescription)")
        }
    }
    
    func updateBusiness(){
        let existingBusiness = businesses[2]
        existingBusiness.addToDepartments(departments[1])
        
        save()
    }
    
    
    func addBusiness(){
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "臉書Facebook" // Entity的 name 新增一個企業名稱 "APPLE"
        
        // add existing departments to the new business 添加現有的 部門到 企業中
        // newBusiness.departments = [departments[0],departments[1]] // 新增 2個部門 到企業當中
        
        // add existing employees to the new business 添加現有的 員工到 企業中
        // newBusiness.employees = [employees[0]]
        
        // add new business to existing department
        // newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        // add new business to existing employee
        // newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        save()
    }
    
    func addDepartment(){
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "米蟲部門"
        newDepartment.businesses = [businesses[0],businesses[1],businesses[2]]
        newDepartment.addToEmployees(employees[1])
        
        // newDepartment.employees = [employees[1]] // employees陣列的第二項
        // newDepartment.addToEmployees(employees[1])
        
        save()
    }
    
    func addEmployee(){
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.age = 5
        newEmployee.dateJoined = Date()
        newEmployee.name = "蠟筆小新"
        
        newEmployee.business = businesses[0]  // 加到一個企業中
        newEmployee.department = departments[1]
        
        save()
    }
    
    func deleteDepartment(){
        let department = departments[2]
        manager.context.delete(department)
        save()
    }
    
    func save(){
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
        }
    }
}


struct CoreDataRelationshipsBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipsViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 20){
                    Button(action: {
                        vm.deleteDepartment()
                   //     vm.getEmployees(forBusiness: vm.businesses[0])
                    }, label: {
                        Text("Button")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)).cornerRadius(25))
                    })
                    
                    ScrollView(.horizontal, showsIndicators: true, content: {
                        HStack(alignment: .top){
                            ForEach(vm.businesses){ business in
                                BusinessView(entity: business)
                            }
                        }
                    })
                    
                    ScrollView(.horizontal, showsIndicators: true, content: {
                        HStack(alignment: .top){
                            ForEach(vm.departments){ department in
                                DepartmentView(entity: department)
                            }
                        }
                    })
                    
                    
                    ScrollView(.horizontal, showsIndicators: true, content: {
                        HStack(alignment: .top){
                            ForEach(vm.employees){ employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    })
                }
                .padding()
            }
            .navigationTitle("Relationships 關係")
        }
    }
}

struct CoreDataRelationshipsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipsBootcamp()
    }
}


struct BusinessView: View{
    
    let entity: BusinessEntity
    
    var body: some View{
        
        VStack(alignment: .leading ,spacing: 20){
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            // 檢查是不是 DepartmentEntity    123123
            if let departments = entity.departments?.allObjects as? [DepartmentEntity]{
                Text("Departments: ")
                
                ForEach(departments){ department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity]{
                Text("Employees:")
                    .bold()
                
                ForEach(employees){ employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300 ,alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}


struct DepartmentView: View{
    
    let entity: DepartmentEntity
    
    var body: some View{
        
        VStack(alignment: .leading ,spacing: 20){
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            // 檢查是不是 businessEntity    123123
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity]{
                Text("Businesses: ")
                
                ForEach(businesses){ business in
                    Text(business.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity]{
                Text("Employees:")
                    .bold()
                
                ForEach(employees){ employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300 ,alignment: .leading)
        .background(Color(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)).opacity(0.5))
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}



struct EmployeeView: View{
    
    let entity: EmployeeEntity
    
    var body: some View{
        
        VStack(alignment: .leading ,spacing: 20){
            Text("Name: \(entity.name ?? "")")
                .bold()
            Text("年齡: \(entity.age)")
            Text("Date joined: \(entity.dateJoined ?? Date() )")
            
            Text("Business: ")
                .bold()
            
            Text(entity.business?.name ?? "")
            
            Text("Department: ")
            
            Text(entity.department?.name ?? "")
        }
        .padding()
        .frame(maxWidth: 300 ,alignment: .leading)
        .background(Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)).opacity(0.5))
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}
