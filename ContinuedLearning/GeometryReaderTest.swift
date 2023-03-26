//
//  GeometryReaderTest.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2023/3/26.
//

import SwiftUI

struct GeometryReaderTest: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            Text("width: \(size.width) height: \(size.height)")
        }
        .frame(width: 100, height: 300)
        .background(Color.gray)
    }
}

struct GeometryReaderTest_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderTest()
    }
}
