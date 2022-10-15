//
//  CLCodable21.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2022/10/12.
//

import SwiftUI

// 解码一般用于下载
struct CustomerModel: Identifiable, Codable {
    let id: String
    let name: String
    let point: Int
    let isPremium: Bool
    
    // 以下的解码代码范式几乎是 Xcode 一键提供的
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case point
//        case isPremium
//    }
    
//    init(id: String, name: String, point: Int, isPremium: Bool) {
//        self.id = id
//        self.name = name
//        self.point = point
//        self.isPremium = isPremium
//    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.point = try container.decode(Int.self, forKey: .point)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
//        try container.encode(self.name, forKey: .name)
//        try container.encode(self.point, forKey: .point)
//        try container.encode(self.isPremium, forKey: .isPremium)
//    }
    
}

class CodableViewModel: ObservableObject {
    
    @Published var customer: CustomerModel? = nil
    
    init(){
        getData()
    }
    
    func getData(){
        
        guard let data = getJSONData() else { return }
        do{
            customer = try JSONDecoder().decode(CustomerModel.self, from: data)
            print("DECODE SUCCESS")
        } catch let error {
            print("ERROR: \(error)")
        }
        
        /* print("JSON Data:")
        print(data) // 模拟从网上下下来未经任何处理的数据
        let jsonString = String(data: data, encoding: .utf8)
        print(jsonString ?? "ERROR") // 模拟String化的数据 */
        
        /* ----- 下面开始演示手动的解码 -----*/
//        if
//            // 手动解码json ↓
//            // as？ 是向下转型的知识
//            let localData = try? JSONSerialization.jsonObject(with: data),
//            let dictionary = localData as? [String:Any],
//            let id = dictionary["id"] as? String,
//            let name = dictionary["name"] as? String,
//            let point = dictionary["point"] as? Int,
//            let isPremium = dictionary["isPremium"] as? Bool{
//
//            let newCustomer = CustomerModel(id: id, name: name, point: point, isPremium: isPremium)
//            customer = newCustomer
//        }
    }
    
    
    func getJSONData() -> Data? {
        
        // 假数据，模拟从网上下载了一个用户的数据
        let customer = CustomerModel(id: "1234", name: "John", point: 22, isPremium: true)
        let jsonData = try? JSONEncoder().encode(customer)
        return jsonData
        
//        let dictionary: [String:Any] = [
//            "id": "1234",
//            "name": "Peter",
//            "point": 5,
//            "isPremium": true
//        ]
//
//        // 将上面的假数据转换成JSON格式，也就是Encode
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        
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
