//
//  CLMultipleSheets#7.swift
//  ContinuedLearning
//
//  Created by PeterZ on 2022/9/19.
//

import SwiftUI

struct RandomModel: Identifiable {
    var id = UUID().uuidString
    var title: String
}

struct CLMultipleSheets_7: View {
    
    @State var randomObject: RandomModel?
    
    var body: some View {
        VStack(spacing: 10){
            Button("Button1") {
                randomObject = RandomModel(title: "ONE")
            }
            Button("Button2") {
                randomObject = RandomModel(title: "TWO")
            }
        }
        .sheet(item: $randomObject) { item in
            SheetView(randomItem: item)
        }
    }
}


struct SheetView: View {
    
    var randomItem: RandomModel
    
    var body: some View {
        Text(randomItem.title)
            .font(.largeTitle)
    }
}

struct CLMultipleSheets_7_Previews: PreviewProvider {
    static var previews: some View {
        CLMultipleSheets_7()
    }
}
