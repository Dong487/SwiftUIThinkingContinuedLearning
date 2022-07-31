//
//  FileManagerBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/20.
//

import SwiftUI

class LocalFileManager{
    
    static let instance = LocalFileManager()
    let folderName: String = "MYApp_Images"
    
    init(){
        creatFolderIfNeeded()
    }
    
    
    // 建立一個資料夾 方便整理使用
    func creatFolderIfNeeded(){
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName) // 資料夾名稱
                .path else{
            return
        }
        // 檢查這個資料夾 是否已經存在
        if !FileManager.default.fileExists(atPath: path){
            do{
                // 123123 路徑 子目錄: true
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("成功建立新的資料夾")
            } catch let error{
                print("創建資料夾時發生錯誤\(error)")
            }
        }
    }
    
    func deleteFolder(){
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName) // 資料夾名稱
                .path else{
            return
        }
        
        do{
            try FileManager.default.removeItem(atPath: path)
            print("成功刪除資料夾！")
        }  catch let error{
            print("刪除資料夾失敗惹@_@\(error)")
        }
    }
    
    func saveImage(image: UIImage ,name: String) -> String{
        // compressionQuality : 原本畫質的幾%   Ex: 1.0 = 原本畫質
        guard
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name) else {
            print("獲取照片失敗")
            return "獲取照片失敗"
        }
     
        do{
            try data.write(to: path)
            print(path)
            return "Save 成功！！！"
        } catch let error{
            print("儲存失敗 ERROR SAVING.\(error)")
            return "儲存失敗 ERROR SAVING.\(error)"
        }
        
                /*
//        // 儲存資料的目錄 for: documentDirectory (文檔)    in: userDomainMask (當前使用者)
//        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) // 文檔
//        let directory2 = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first // 緩存 快取 ：新聞、地圖、可下載內容 等
//        let directory3 = FileManager.default.temporaryDirectory // 臨時的
//
//        let path = directory2?.appendingPathComponent("\(name).jpg")
//
//        print(directory)
//        print(directory2)
//        print(directory3)
//
//        print(path)
 */
        
    }
    // 取得圖片  必須要有儲存時的路徑(path) -> URL
    func getImage(name: String) -> UIImage? {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("獲取路徑錯誤Q_Q")
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    
    func deleteImage(name: String) -> String{
        guard
            let path = getPathForImage(name: name),
            FileManager.default.fileExists(atPath: path.path) else {
            print("獲取路徑錯誤Q_Q")
            return "獲取路徑錯誤Q_Q"
        }
        
        do{
            try FileManager.default.removeItem(at: path)
            print("你已成功刪除圖片")
            return "你已成功刪除圖片"
        } catch let error{
            print("刪除圖片失敗\(error)")
            return "刪除圖片失敗\(error)"
        }
    }
    
    // 這整個 func 回傳一個 路徑URL
    func getPathForImage(name: String) -> URL? {
        
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .appendingPathComponent("\(name).jpg") else{
            print("ERROR getting path . 取得路徑錯誤")
            return nil
        }
        return path
    }
}

class FileManagerViewModel: ObservableObject{
    
    @Published var image: UIImage? = nil
    let imageName: String = "a1"
    let manager = LocalFileManager.instance
    @Published var infoMessage: String = ""
    
    init(){
        getImageFromAssetsFolder() // 拉進 Xcode的 Assets 圖片
      //  getImageFromFileManager() // 儲存在 手機內 FileManager
    }
    
    func getImageFromAssetsFolder(){
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager(){
        image = manager.getImage(name: imageName)
    }
    
    func saveImage(){
        guard let image = image else { return }
        infoMessage = manager.saveImage(image: image, name: imageName)
    }
    
    func deleteImage(){
        infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
}

struct FileManagerBootcamp: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                if let image = vm.image{
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(15)
                    
                }
                HStack {
                    Button(action: {
                        vm.saveImage()
                    }, label: {
                        Text("Save to FM!")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
                            .cornerRadius(15)
                    })
                    
                    Button(action: {
                        vm.deleteImage()
                    }, label: {
                        Text("Delete from FM!")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color(#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)))
                            .cornerRadius(15)
                    })
                }
                
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(#colorLiteral(red: 0.7393861413, green: 0.4925765395, blue: 0.8824526668, alpha: 0.9562018408)))

                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

struct FileManagerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerBootcamp()
    }
}
