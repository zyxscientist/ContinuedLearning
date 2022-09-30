//
//  CLCoreData15.swift
//  ContinuedLearning
//
//  Created by PeterZ on 2022/9/29.
//

import SwiftUI
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
    
    // 增加数据
    func addFruit(name: String){
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = name
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

struct CLCoreData15: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State var textFiledOfText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    TextField("Enter some fruit", text: $textFiledOfText)
                        .keyboardType(.decimalPad) // 调用键盘类型
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .font(.headline)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                    
                    Button {
                        guard !textFiledOfText.isEmpty else { return }
                        vm.addFruit(name: textFiledOfText)
                        textFiledOfText = ""
                    } label: {
                        Text("Save")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .padding(.vertical, 15)
                            .padding(.horizontal)
                            .background(.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                    }
                }
                .navigationTitle("Fruit")
                .padding()
                
                List {
                    // 将CoreData的数据显示出来
                    ForEach(vm.savedEntities){ fruits in
                        Text(fruits.name ?? "")
                    }
                }
            }
        }
    }
}

struct CLCoreData15_Previews: PreviewProvider {
    static var previews: some View {
        CLCoreData15()
    }
}
