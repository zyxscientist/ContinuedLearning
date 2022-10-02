//
//  FruitViewModel.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2022/10/2.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    
    // 数据库容器
    let container: NSPersistentContainer
    @Published var savedEntities:[FruitEntity] = []
    
    init(){
        // 第一步：创建container并且连接到名为FruitsContainer的数据库
        container = NSPersistentContainer(name: "FruitsContainer") // 写上创建的数据库的名字
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("LOADING COREDATA ERROR: \(error)")
            }
        }
        // 第二步：从里面调取目标数据
        fetchFruits()
    }
    
    // 获取目标数据
    func fetchFruits(){
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")//调取对象
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func updateFruit(entity: FruitEntity){
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    // 增加数据
    func addFruit(name: String){
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = name
        saveData()
    }
    
    // 删除数据
    func deleteFruit(indexSet: IndexSet){
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    // 保存数据
    func saveData(){
        do{
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Saving Error: \(error)")
        }
    }
}
