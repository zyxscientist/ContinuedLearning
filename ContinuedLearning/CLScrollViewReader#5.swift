//
//  CLScrollViewReader#5.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2022/9/19.
//

import SwiftUI

struct CLScrollViewReader_5: View {
    
    @State var topId: Int = 0
    
    var body: some View {
        
        VStack {
            ScrollView{
                ScrollViewReader { proxy in
                    ForEach(0..<50) { index in
                        Text("\(index)")
                            .id(index)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 14.0, style: .continuous))
                            .padding()
                            }
                            .onChange(of: topId) { newValue in
                                proxy.scrollTo(0)
                    }
                }
            }
            
            HStack {
                Button("TOP") {
                    topId += 1
                    print(topId)
                }
            }
        }
    }
}


struct CLScrollViewReader_5_Previews: PreviewProvider {
    static var previews: some View {
        CLScrollViewReader_5()
    }
}
