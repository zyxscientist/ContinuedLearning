//
//  PersonViewModel.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2022/9/22.
//

import Foundation

class PersonViewModel: ObservableObject {
    
    @Published var dataArray: [PersonModel] = []
    @Published var filterArray: [PersonModel] = []
    @Published var mappedArray: [String] = []
    
    init(){
        getPerson()
        updateFilterArray()
    }
    
    func updateFilterArray(){
        
        //Sort - 排序
        /* Sort 一个经典闭包
        let sortedArray = dataArray.sorted { user1, user2 in
            return user1.points > user2.points
        }
        filterArray = sortedArray
        
        // 究极缩写
        // filterArray = sortedArray = dataArray.sorted(by: {$0.points > $1.points})
         */
        
        //Filter - 按照要求筛选
        /* let sortedArray = dataArray.filter { user in
            user.points > 20
        }
        filterArray = sortedArray */
        
        //Map - 主要就是用来将数据从模型中抽离出来
        /* mappedArray = dataArray.map({ user in
            user.name
        })
        
        //.compactMap(<#T##transform: (PersonModel) throws -> ElementOfResult?##(PersonModel) throws -> ElementOfResult?#>)
        // 处理可选时要用这个，如果没有返回就直接被跳过 */
        
        
        // 上面用到的可以挂在一起混合用
        mappedArray = dataArray
                        .sorted(by: {$0.points > $1.points})
                        .filter({ user in
                            user.points > 20
                        })
                        .map({user in user.name})
    }
    
    func getPerson(){
        let person1 = PersonModel(name: "Tom", points: 15, isVerified: false)
        let person2 = PersonModel(name: "Jack", points: 14, isVerified: true)
        let person3 = PersonModel(name: "John", points: 12, isVerified: false)
        let person4 = PersonModel(name: "So-Ching", points: 5, isVerified: false)
        let person5 = PersonModel(name: "MO", points: 5, isVerified: false)
        let person6 = PersonModel(name: "Peter", points: 100, isVerified: true)
        
        dataArray.append(contentsOf: [person1,
                         person2,
                         person3,
                         person3,
                         person4,
                         person5,
                         person6
        ])
    }
    
    
}
