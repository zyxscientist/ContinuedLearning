//
//  CLCodable21.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2022/10/12.
//

import SwiftUI

struct CustomerModel: Identifiable {
    let id: String
    let name: String
    let point: Int
    let isPremium: Bool
}

class CodableViewModel: ObservableObject {
    
    @Published var customer: CustomerModel? = nil
    
    init(){
        getData()
    }
    
    func getData(){
        
        guard let data = getJSONData() else { return }
        /* print("JSON Data:")
        print(data) // 模拟从网上下下来未经任何处理的数据
        let jsonString = String(data: data, encoding: .utf8)
        print(jsonString ?? "ERROR") // 模拟String化的数据 */
        if
            let localData = try? JSONSerialization.jsonObject(with: data),
            let dictionary = localData as? [String:Any] {
                let id = dictionary["id"] as! String
                let name = dictionary["name"] as! String
                let point = dictionary["point"] as! Int
                let isPremium = dictionary["isPremium"] as! Bool
            
            let newCustomer = CustomerModel(id: id, name: name, point: point, isPremium: isPremium)
        }
        
    }
    
    func getJSONData() -> Data? {
        // 假数据
        let dictionary: [String:Any] = [
            "id": "1234",
            "name": "Peter",
            "point": 5,
            "isPremium": true
        ]
        
        // 将上面的假数据转换成JSON格式
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        return jsonData
    }
    
}

struct CLCodable21: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 20){
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.point)")
                Text(customer.isPremium.description)
            }
        }
    }
}

struct CLCodable21_Previews: PreviewProvider {
    static var previews: some View {
        CLCodable21()
    }
}
