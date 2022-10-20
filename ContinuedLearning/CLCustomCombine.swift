//
//  CLCustomCombine.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2022/10/20.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    var time: AnyCancellable?
    
    init(){
        setUpTimer()
    }
    
    func setUpTimer(){
        time = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink{ [weak self] _ in
                self?.count += 1
            }
    }
    
}

struct CLCustomCombine: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        Text("\(vm.count)")
            .font(.title)
    }
}

struct CLCustomCombine_Previews: PreviewProvider {
    static var previews: some View {
        CLCustomCombine()
    }
}
