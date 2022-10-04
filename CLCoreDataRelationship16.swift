//
//  CLCoreDataRelationship16.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2022/10/2.
//

import SwiftUI
import CoreData

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

class CoreDataRelationshipViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var business: [BusinessEntity] = []
    
    init(){
        getBusinesses()
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Apple"
        save()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        do {
            business = try manager.container.viewContext.fetch(request)
        } catch let error {
            print("ERROR FETCHING: \(error)")
        }
    }
    
    func save() {
        do{
            try manager.container.viewContext.save()
            print("Saved successfuly")
        } catch let error {
            print("Saving data error: \(error.localizedDescription)")
        }
        getBusinesses()
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
                        cdrvm.addBusiness()
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
                    
                    // 显示 CoreData 中的数据
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(cdrvm.business) { business in
                                BusniessView(entity: business)
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
        .shadow(radius: 10)
    }
}
