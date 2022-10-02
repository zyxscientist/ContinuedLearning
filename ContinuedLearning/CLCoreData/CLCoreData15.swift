//
//  CLCoreData15.swift
//  ContinuedLearning
//
//  Created by PeterZ on 2022/9/29.
//

import SwiftUI

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
                            .onTapGesture {
                                vm.updateFruit(entity: fruits)
                            }
                    }.onDelete(perform: vm.deleteFruit)
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
