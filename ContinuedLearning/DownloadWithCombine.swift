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
            // 检查错误，处理错误
            .tryMap { (data, response) -> Data in
                guard
                    let response  = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else
                {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            // 解码
            .decode(type: [ArticleModel].self, decoder: JSONDecoder())
            // 赋值
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
