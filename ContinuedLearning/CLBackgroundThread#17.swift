//
//  CLBackgroundThread#17.swift
//  ContinuedLearning
//
//  Created by PeterZ on 2022/10/10.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray:[String] = []
    
    
    
    func fetchData(){
        
        // 不建议让后台进程能够直接影响前端UI，所以我们要加.main.async
        DispatchQueue.global().async {
            let newData = self.downloadData()
            
            // 要求改变UI的程序在主线程中进行
            DispatchQueue.main.async {
                self.dataArray = newData
            }
        }
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        
        return data
    }
    
    
}

struct CLBackgroundThread_17: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .font(.title)
                    .fontWeight(.bold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                }
            }
        }
    }
}

struct CLBackgroundThread_17_Previews: PreviewProvider {
    static var previews: some View {
        CLBackgroundThread_17()
    }
}
