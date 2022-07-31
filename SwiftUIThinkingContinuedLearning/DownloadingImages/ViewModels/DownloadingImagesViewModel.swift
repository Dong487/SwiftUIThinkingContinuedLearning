//
//  DownloadingImagesViewModel.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/21.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject{
    
    @Published var dataArray: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()

    
    let dataService = PhotoModelDataService.instance
    
    init(){
        addSubscribers()
    }
    
    // 追蹤 PhotoModelDataService 裡面的 photoModels
    func addSubscribers(){
        dataService.$photoModels
            .sink { [weak self] (returnedPhotoModels)  in
                self?.dataArray = returnedPhotoModels
            }
            .store(in: &cancellables)
    }
}
