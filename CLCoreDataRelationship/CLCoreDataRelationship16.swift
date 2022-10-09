//
//  CLCoreDataRelationship16.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2022/10/2.
//

import SwiftUI
import CoreData

// 管理器 - 专门用于初始化 CoreData
class CoreDataManager{
    
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init(){
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("LOADING COREDATA ERROR: \(error.localizedDescription)")
            }
        }
        context = container.viewContext
    }
    
    func save(){
        do{
            try context.save()
        } catch let error {
            print("Saving Error: \(error.localizedDescription)")
        }
    }
    
}

// ModelView
class CoreDataRelationshipViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var business: [BusinessEntity] = []
    @Published var department: [DepartmentEntity] = []
    @Published var employee: [EmployeeEntity] = []
    
    // 初始化就要拉取 CoreData 里面的数据以正常显示
    init(){
        getBusinesses()
        getDepartment()
        getEmployee()
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "🍎Apple"
        
        // 由于建立了 relationship 我们可以以 newBusiness 对 department 进行编辑
        // newBusiness.departments = []
        
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "📣Marketing"
        newDepartment.business = [business[0]] // 以这种方式指定 relationship
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.name = "🧑‍💻Peter"
        newEmployee.age = 29
        newEmployee.dateJoined = Date()
        newEmployee.business = business[0]
        newEmployee.department = department[0]
        save()
    }
    
    // 获取数据
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        do {
            business = try manager.container.viewContext.fetch(request)
        } catch let error {
            print("ERROR FETCHING: \(error)")
        }
    }
    
    // 获取数据
    func getDepartment() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do {
            department = try manager.container.viewContext.fetch(request)
        } catch let error {
            print("ERROR FETCHING: \(error)")
        }
    }
    
    func getEmployee(){
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do {
            employee = try manager.container.viewContext.fetch(request)
        } catch let error {
            print("ERROR FETCHING: \(error)")
        }
    }
    
    func save() {
        
        // 每次保存的时候确保 ViewModel 里面的属性已经被清空，不然数组内容会被成串记录
        business.removeAll()
        department.removeAll()
        employee.removeAll()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            do{
                try self.manager.container.viewContext.save()
                print("Saved successfuly")
            } catch let error {
                print("Saving data error: \(error.localizedDescription)")
            }
            // 从 CoreData 中拉取保存执行之后的数据
            self.getBusinesses()
            self.getDepartment()
            self.getEmployee()
        }
    }
    
}

struct CLCoreDataRelationship16: View {
    
    // 实例化
    @StateObject var cdrvm = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    Button {
                        // 手动造伪数据
                        //cdrvm.addBusiness()
                        cdrvm.addEmployee()
                    } label: {
                        Text("Perform Action")
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                            .padding()
                    }
                    
                    // 显示 CoreData 中 Business 的数据
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(cdrvm.business) { business in
                                BusniessView(entity: business)
                            }
                        }.padding()
                    }
                    
                    // 显示 CoreData 中 Department 的数据
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(cdrvm.department) { department in
                                DepartmentView(entity: department)
                            }
                        }.padding()
                    }
                    
                    // 显示 CoreData 中 Employee 的数据
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(cdrvm.employee) { employee in
                                EmployeeView(entity: employee)
                            }
                        }.padding()
                    }

                }
            }.navigationTitle("Company")
        }
    }
}

struct CLCoreDataRelationship16_Previews: PreviewProvider {
    static var previews: some View {
        CLCoreDataRelationship16()
    }
}

// Busniess 卡片
struct BusniessView: View {
    
    let entity: BusinessEntity
    
    var body: some View{
        
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "") ")
                .font(.system(size: 20))
                .bold()
            
            // 获取 relationship 数据
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments:")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            
            // 获取 relationship 数据
            if let empolyees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(empolyees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(width: 200, alignment: .leading)
        .background(Color.purple.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
        .shadow(radius: 8)
    }
}

// Department 卡片
struct DepartmentView: View {
    
    let entity: DepartmentEntity
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "") ")
                .font(.system(size: 20))
                .bold()
            
            // 获取 relationship 数据
            if let businesses = entity.business?.allObjects as? [BusinessEntity] {
                Text("Businesses:")
                    .bold()
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
            }
            
            // 获取 relationship 数据
            if let empolyees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(empolyees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(width: 200, alignment: .leading)
        .background(Color.green.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
        .shadow(radius: 8)
    }
}


// Employee 卡片
struct EmployeeView: View {
    
    let entity: EmployeeEntity
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "") ")
                .font(.system(size: 20))
                .bold()
            
            Text("Age: \(entity.age) ")
            
            Text("Join Date: \(entity.dateJoined ?? Date()) ")
                .lineLimit(1)
            
            Text("Business: ")
            Text(entity.business?.name ?? "")
            
            Text("Department: ")
            Text(entity.department?.name ?? "")
        }
        .padding()
        .frame(maxWidth: 250, alignment: .leading)
        .background(Color.blue.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
        .shadow(radius: 8)
        
    }
}
        
