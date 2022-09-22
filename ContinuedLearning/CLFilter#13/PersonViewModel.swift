//
//  PersonViewModel.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2022/9/22.
//

import Foundation

class PersonViewModel: ObservableObject {
    
    @Published var dataArray: [PersonModel] = []
    
    init(){
        getPerson()
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
