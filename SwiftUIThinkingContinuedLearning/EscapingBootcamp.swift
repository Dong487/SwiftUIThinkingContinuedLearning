//
//  EscapingBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/18.
//

import SwiftUI

class EcapingViewModel:ObservableObject{
    
    @Published var text: String = "哈摟你好嗎"
    
    func getData(){
        downloadData4 { [weak self] (returnedResult) in
            self?.text = returnedResult.data
        }
    }
    
    func downloadData() -> String {
        return "新的 Data!!"
    }
    
    // _ 下底線(也可以給名稱): 外部給參數data的時候看到的名字
    //  -> Void  = ->()
    func downloadData2(completionHandler: (_ data: String) -> Void) {
        completionHandler("DATA 222222!")
    }
    
    
    func downloadData3(completionHandler: @escaping (_ data: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completionHandler("DATA 3333333!")
        }
    }
    

    func downloadData4(completionHandler: @escaping (DownloadResult) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let result = DownloadResult(data: "SBBBBBB")
            completionHandler(result)
        }
    }
    
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let result = DownloadResult(data: "SBBBBBB")
            completionHandler(result)
        }
    }
}

// -> () = -> Void
typealias DownloadCompletion = (DownloadResult) -> ()

struct DownloadResult{
    let data: String
}

struct EscapingBootcamp: View {
    
    @StateObject var vm = EcapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
            .onTapGesture {
                vm.getData()
            }
    }
}

struct EscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EscapingBootcamp()
    }
}
