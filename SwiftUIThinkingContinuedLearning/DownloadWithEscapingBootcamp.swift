//
//  DownloadWithEscapingBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/19.
//

import SwiftUI

struct PostModel: Identifiable, Codable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadwithEscapingViewModel: ObservableObject{
    
    @Published var posts: [PostModel] = []
    
    init(){
        getPosts()
    }
    
    func getPosts(){
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(fromURL: url) { (returnedData) in
            if let data = returnedData{
                // 單個改多個: PostModel + []
                // self?.posts.append(newPosts) -> self?.posts = newPosts
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in
//                    self?.posts.append(newPosts)
                    self?.posts = newPosts
                }
            } else{
                print("No data returned")
            }
        }
    }
    // 經常使用
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()){
        
        // 一個 url 任務 可能 獲取 data、response、error
        // 經常使用
        // 從 url 獲取 data 並檢查是否成功
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 &&  response.statusCode < 300 else{
                    print("Download data 過程中發生錯誤 :((")
                completionHandler(nil)
                    return
            }
            // 假如上面條件都成功符合 則執行下面
            completionHandler(data)
        }
        .resume()
    }
    
}

struct DownloadWithEscapingBootcamp: View {
    
    @StateObject var vm = DownloadwithEscapingViewModel()
    
    var body: some View {
        List{
            ForEach(vm.posts) { post in
                VStack(alignment: .leading){
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity ,alignment: .leading)
                
            }
        }
    }
}

struct DownloadWithEscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscapingBootcamp()
    }
}
