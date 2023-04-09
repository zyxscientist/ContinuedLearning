//
//  DownloadWithCombine.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2022/10/16.
//

import SwiftUI
import Combine

struct ArticleModel: Codable, Identifiable {
    let userId, id: Int
    let title, body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var article: [ArticleModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init(){
        getArticle()
    }
    
    func getArticle() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // 使用Combine框架来做同样的事情
        URLSession.shared.dataTaskPublisher(for: url)
            // 表明接受后要在主线程更新
            .receive(on: DispatchQueue.main)
            // 检查服务器返回的状态码，根据状态码对应具体错误，且如果有错误就跳出，不返回 data
            .tryMap { (data, response) -> Data in
                guard
                    let response  = response as? HTTPURLResponse, // , 是guard语法的一部分连续俩条件可以用,链接起来
                    response.statusCode >= 200 && response.statusCode < 300 else
                {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            // 解码
            .decode(type: [ArticleModel].self, decoder: JSONDecoder())
            // 接收publisher发出的值，直到它不在发送新值
            .sink { (completion) in
                print("COMPLETION: \(completion)")
            } receiveValue: { [weak self] (returnedArticle) in
                self?.article = returnedArticle
                print("APPEND TO ARTICLE")
            }
            // 不知道干嘛
            .store(in: &cancellables)
    }
    
}

struct DownloadWithCombine: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        NavigationView {
            List{
                NavigationLink("HH", destination: Text("11"))
                ForEach(vm.article) { article in
                        LazyVStack(alignment: .leading) {
                            Text(article.title)
                                .font(.headline)
                            Text(article.body)
                                .foregroundColor(.gray)
                        }
                }
            }.navigationTitle("1111")
        }
    }
}

struct DownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombine()
    }
}
