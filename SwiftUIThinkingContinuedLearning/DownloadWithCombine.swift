//
//  DownloadWithCombine.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/19.
//

import SwiftUI
import Combine

struct PostModel1: Identifiable, Codable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject{
    
    @Published var posts: [PostModel1] = []
    var cancellables = Set<AnyCancellable>()  // 需要先 import Combine
    
    init(){
        getPosts()
    }
    
    func getPosts(){
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // 1. 每個月訂閱包裹
        // 2.
        // 3. 寄送包裹到你家門前
        // 4. 檢查包裹包裝
        // 5. 打開包裹 確認內容物
        // 6. 使用 裡面的 物品
        // 7. 隨時可以取消 退貨
//  - - - - - - - - - - - - - - - - - - - - - - -
        // 1) 建立 publisher
        // 2) 在後台 訂閱追蹤 publisher
        // 3) .receive 在主線程 接收
        // 4) .tryMap -> Check檢查 response 正常
        // 5) .decode (解開data )
        // 6) .sink (使用 -> 放到你的App當中)
        // 7) .store (隨時能取消)
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel1].self, decoder: JSONDecoder())
            .sink { (completion) in
                // 這邊可以 有 2種情況  完成 or 錯誤
                
                // ** 可以直接把sink 拆成 2個 **
                //  .replaceError(with: []) && .sink(receiveValue: )
                // 錯誤時給一個空白的數組      &&     成功時連接到你的宣告
                
                // ** 也可以使用 switch **
//                switch completion{
//                case .finished:
//                    print("成功的情況")
//                case .failure(let error):
//                    print("失敗的情況")
//                }
            } receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts    // 接收到的 連接到你的 宣告
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data{
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombine: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List{
            ForEach(vm.posts){ post in
                VStack(alignment: .leading){
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombine()
    }
}
