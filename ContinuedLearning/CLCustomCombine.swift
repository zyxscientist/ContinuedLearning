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
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    init(){
        setUpTimer()
        textFieldTextSubscriber()
    }
    
    // Combine的接收功能演示：
    // 利用Combine的接收特性来做一个校验输入框合法性的功能
    func textFieldTextSubscriber() {
        $textFieldText
            /* debounce用作控制更新时间，指0.5秒之后再执行下方map函数，
            如果不这样的话可能会造成大量的算力浪费 */
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .map { (text) -> Bool in
                if text.count > 0 {
                    return true
                }
                return false
            }
            .sink(receiveValue: { [weak self] (isValid) in
                self?.textIsValid = isValid
            })
            // 没弄懂为什么不写下面这样就不生效？我们可以做点实验
            .store(in: &cancellables)
    }
    
    func setUpTimer(){
        time = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink{ [weak self] _ in
                // 每次发布的时候都让 count 自加 1
                self?.count += 1
                
                // 假如count不为空，且count>=10的时候，发布取消
                /* if let count = self?.count, count >= 10
                 只是一种简便的让其不为空的写法且>=10的写法  */
                if let count = self?.count, count >= 10 {
                    self?.time?.cancel()
                }
            }
    }
    
}

struct CLCustomCombine: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
            
            Text(vm.textIsValid.description)
            
            TextField("Type something here", text: $vm.textFieldText)
                .padding(.horizontal)
                .frame(height: 55)
                .background(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                .padding()
                .overlay(
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity( vm.textIsValid && vm.textFieldText.count <= 3 ? 1.0 : 0.0)
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.textIsValid && vm.textFieldText.count > 3 ? 1.0 : 0.0)
                    }
                    .font(.title)
                    .padding(.trailing)
                    .padding()
                    , alignment: .trailing
                )
                
        }
    }
}

struct CLCustomCombine_Previews: PreviewProvider {
    static var previews: some View {
        CLCustomCombine()
    }
}
