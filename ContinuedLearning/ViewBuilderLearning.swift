//
//  ViewBuilderLearning.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2023/3/26.
//

import SwiftUI

/// 这个是一个非常常规的视图结构体，一般来讲都够用，不过它比较不灵活
/// 每次要加元素都要手动回来这里hardcode一波，在某些场景下这是很麻烦
/// 的，而 ViewBuilder 就是来解决这种问题的，ViewBuilder 可以创建能够接
/// 受View作为参数的结构体，从而使我们有可能在既有的结构体当中插入新
/// 视图。
struct HeaderViewRegular: View {
    
    let title: String
    let description: String?
    let iconName: String?
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                if let description = description{
                    Text(description)
                        .font(.callout)
                }
                
                if let iconName = iconName {
                    Image(systemName: iconName)
                }
                
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
}

/// 我们尝试使用 ViewBuilder 来解决灵活性的问题，我们用@ViewBuilder修饰content
/// 这个参数，而又故意将content变为一个返回 View 的函数，是它传入的参数可以以
/// 闭包的形式传入，看起来更加优雅。
/// 这样的结构体视图具有更好的灵活性。
struct HeaderViewViewBuilder<Content: View>: View{
    
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content:() -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                content
                
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
}

struct ViewBuilderLearning: View {
    var body: some View {
        VStack {
            HeaderViewRegular(title: "GPT-3", description: nil, iconName: "heart.fill")
            HeaderViewRegular(title: "GPT-4", description: "OpenAI", iconName: "flag.checkered")
            
            // ViewBuilder 构建
            HeaderViewViewBuilder(title: "GPT-3") {
                Image(systemName: "heart.fill")
            }
            HeaderViewViewBuilder(title: "GPT-4") {
                Text("Open AI")
                Image(systemName: "flag.checkered")
            }
            Spacer()
            
        }
    }
}

struct ViewBuilderLearning_Previews: PreviewProvider {
    static var previews: some View {
        ViewBuilderLearning()
    }
}
