//
//  CacheBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/21.
//

import SwiftUI

class CacheManager{
    
    static let instance = CacheManager()
    private init() { }
    
    // NSCache <key, value>
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100 // 內存大小
        cache.totalCostLimit = 1024 * 1024 * 100 // 100mb
        return cache
    }()  // ()= 初始化
    
    func add(image: UIImage ,name: String) -> String{
        
        imageCache.setObject(image, forKey: name as NSString) // name型態為 String  轉成 NSString
        return "添加到 cache!"
    }
    
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString) // name型態為 String  轉成 NSString
        return "刪除 cache!"
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class CacheViewModel: ObservableObject{
    
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    @Published var infoMessage: String = ""
    
    let imageName: String = "a1"
    let manager = CacheManager.instance
    
    init(){
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder(){
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache(){
        guard let image = startingImage else { return }
        infoMessage = manager.add(image: image, name: imageName)
    }
    
    func removeFromcache(){
        infoMessage = manager.remove(name: imageName)
    }
    
    func getFromCache(){
        if let returnedImage = manager.get(name: imageName){
            cachedImage = returnedImage
            infoMessage = "從 Cache 獲取到圖片"
        } else {
            infoMessage = "沒東C"
        }
        
    //    cachedImage = manager.get(name: imageName) //123123
    }
}

struct CacheBootcamp: View {
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                if let image = vm.startingImage{
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(15)
                    
                }
                Text(vm.infoMessage)
                    .font(.headline)
                    .foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                
                HStack {
                    Button(action: {
                        vm.saveToCache()
                    }, label: {
                        Text("Save to Cache!")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
                            .cornerRadius(15)
                    })
                    
                    Button(action: {
                        vm.removeFromcache()
                    }, label: {
                        Text("Delete from Cache!")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color(#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)))
                            .cornerRadius(15)
                    })
                }
                
                Button(action: {
                    vm.getFromCache()
                }, label: {
                    Text("get from Cache!")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(Color(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)))
                        .cornerRadius(15)
                })
                
                if let image = vm.cachedImage{
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(15)
                    
                }

                    

                Spacer()
            }
            .navigationTitle("Cache Manager")
        }
    }
}

struct CacheBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CacheBootcamp()
    }
}
