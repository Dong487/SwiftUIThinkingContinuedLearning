//
//  PhotoModelFileManager.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/21.
//

// 提供Cache存取的 資料夾位置
import Foundation
import SwiftUI

class PhotoModelFileManager {
    
    static let instance = PhotoModelFileManager()
    let folderName = "downloaded_photos"
    
    private init() {
        
    }
    
    private func creatFolderIfNeeded(){
        guard let url = getFolderPath() else { return }
        
        // 假如這個路徑沒有資料夾  創立一個資料夾
        if !FileManager.default.fileExists(atPath: url.path){
            do{
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                print("建立 資料夾")
            } catch let error {
                print("ERROR creating folder. \(error)")
            }
        }
    }
    
    
    // 1) 先建一個路徑
    private func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    // ... /downloaded_photos/
    // ... /downloaded_photos/image_name.png
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else {
            return nil
        }
        return folder.appendingPathComponent(key + ".png")
    }
    
    func add(key: String ,value: UIImage){
        guard
            let data = value.pngData(),
            let url = getImagePath(key: key) else { return }
        
        do{
            try data.write(to: url)
        } catch let error{
            print("ERROR saving to file manager. \(error)")
        }
    }
    
    func get(key: String) -> UIImage?{
        guard
            let url = getImagePath(key: key),
            FileManager.default.fileExists(atPath: url.path) else{
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
}
