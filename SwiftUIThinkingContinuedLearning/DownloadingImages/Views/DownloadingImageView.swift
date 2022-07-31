//
//  DownloadingImageView.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/21.
//

import SwiftUI

struct DownloadingImageView: View {
    
    // 因爲這行宣告 會跟 init 同時初始化  所以不能直接在這給url
    @StateObject var loader : ImageLoadingViewModel
  
    init(url: String ,key: String){
        _loader = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
    }
    
    
    
    var body: some View {
        ZStack{
            if loader.isLoading{
                ProgressView()
            } else if let image = loader.image{
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}

struct DownloadingImageView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImageView(url: "https://via.placeholder.com/150/92c952", key: "7")
            .frame(width: 75, height: 75)
            .previewLayout(.sizeThatFits)
    }
}
