//
//  PersonModel.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2022/9/22.
//

import Foundation

struct PersonModel: Identifiable {
    var id = UUID().uuidString
    var name: String
    var points: Int
    var isVerified: Bool
}
