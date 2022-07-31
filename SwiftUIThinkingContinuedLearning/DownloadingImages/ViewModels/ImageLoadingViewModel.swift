//
//  ImageLoadingViewModel.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/21.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject{
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    let manager = PhotoModelCacheManager.instance // 存在手機暫存裡面 關掉之後會不見 可設定暫存大小
//    let manager = PhotoModelFileManager.instance // 存在手機檔案裡面


    let urlString: String // 圖片的網址
    let imageKey: String
    
    init(url: String ,key: String){
        urlString = url
        imageKey = key
        getImage()
    }
    
    func getImage(){
        if let savedImage = manager.get(key: imageKey){
            image = savedImage
            print("從手機獲取圖片")
        } else {
            downloadImage()
            print("從網路下載圖片")
        }
    }
    
    
    func downloadImage(){
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map{ UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] ( returnedImage) in
                guard
                    let self = self,  //123123
                    let image = returnedImage else { return }
                
                self.image = returnedImage   // 存值進去
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)

        
    }
}
