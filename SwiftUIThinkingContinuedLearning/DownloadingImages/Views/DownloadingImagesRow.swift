//
//  DownloadingImagesRow.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/21.
//

import SwiftUI

struct DownloadingImagesRow: View {
    
    let model: PhotoModel
    
    var body: some View {
        HStack{
            DownloadingImageView(url: model.url ,key: "\(model.id)") // 123123 iD?
                .frame(width: 75, height: 75)
            
            VStack(alignment: .leading){
                Text(model.title)
                    .font(.headline)
                Text(model.url)
                    .foregroundColor(.gray)
                    .italic()   // 斜體
            }
            .frame(maxWidth: .infinity ,alignment: .leading)
        }
    }
}

struct DownloadingImagesRow_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesRow(model: PhotoModel(albumId: 7, id: 7, title: "DONG", url: "https://via.placeholder.com/150/92c952", thumbnailUrl: "https://via.placeholder.com/150/92c952"))
            .previewLayout(.sizeThatFits)
    }
}
