//
//  DownloadJSONFromAPI22.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2022/10/15.
//

import SwiftUI

struct PostModel: Codable, Identifiable {
    let userId, id: Int
    let title, body: String
}


class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init(){
        getPosts()
    }
    
    func getPosts(){
        
        // 获取URL，并且转化为 Swift 的 URL 格式
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // URLSession 会在非主线程运行，Swift是这么设计的
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // 处理 data
            guard let data = data else {
                print("No Data.")
                return
            }
            
            // 处理 error 情况
            guard error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            // 处理 respon 情况
            guard let response = response as? HTTPURLResponse else {
                print("Invalid Response")
                return
            }
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("\(response.statusCode)")
                return
            }
            
            // Consolelog 检查一下下下来的是什么
            print("DOWNLOAD SUCCESSFULLY")
            print(data)
            // 转化JSON成可以打印出具体内容的String
            let jsonString = String(data: data, encoding: .utf8)
            print(jsonString ?? "ERROR")
            
            guard let newPost = try? JSONDecoder().decode([PostModel].self, from: data) else
            {
                print("DECODE FAILED")
                return
            }
            
            /* 这一步开始会影响UI更新，所以要求它到会主线程执行 */
            /* 这里会产生强引用循环问题，所以要 weak self */
            DispatchQueue.main.async { [weak self] in
                self?.posts.append(contentsOf: newPost)
                print("APPEND TO POST")
            }
            
        }.resume()
        
    }
}

struct DownloadJSONFromAPI22: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        List{
            ForEach(vm.posts) { post in
                LazyVStack(alignment: .leading) {
                    Text(post.title)
                        .font(.title)
                        .lineLimit(1)
                    Text(post.body)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }
            }
        }
    }
}

struct DownloadJSONFromAPI22_Previews: PreviewProvider {
    static var previews: some View {
        DownloadJSONFromAPI22()
    }
}
