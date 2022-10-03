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
        container = NSPersistentContainer(name: "")
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
    
}

struct CLCoreDataRelationship16: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CLCoreDataRelationship16_Previews: PreviewProvider {
    static var previews: some View {
        CLCoreDataRelationship16()
    }
}
