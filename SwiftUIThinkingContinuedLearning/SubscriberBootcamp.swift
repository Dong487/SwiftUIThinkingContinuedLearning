//
//  SubscriberBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/20.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject{
    
    @Published var count: Int = 0
//    var timer: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    @Published var showButton: Bool = false
    
    init(){
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubcriber()
    }
    
    
    func addTextFieldSubscriber(){
        $textFieldText
            // 延遲動作 (常用在搜尋)
            // 等到你的動作結束後 0.5秒 才發布
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            // 接收輸入的 text  回傳布林值
            .map{ (text) -> Bool in
                if text.count > 3{
                    return true
                }
                return false
            }
            //.assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] (isValid) in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    
    func setUpTimer(){
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect() // 出現就執行
            .sink{ [weak self ] _ in
                // 檢查 count 是否有值 (不是nil)
                guard let self = self else { return }
                self.count += 1
                
//                if self.count >= 10{
//                    for item in self.cancellables{
//                        item.cancel()
//                    }
//                }
            }
            .store(in: &cancellables)
    }
    
    
    func addButtonSubcriber(){
        $textIsValid
            .combineLatest($count)      // 與count 結合
            // 結合 2 項  並作判斷
            .sink{ [weak self](isValid , count) in
                guard let self = self else { return }
                //
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}

struct SubscriberBootcamp: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            Text(vm.textIsValid.description)
            
            TextField("輸入一些東ＣＣＣＣ", text: $vm.textFieldText)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)).opacity(0.3))
                .cornerRadius(15)
                .overlay(
                    ZStack{
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0.0 :
                                vm.textIsValid ? 0.0 : 1.0
                            )
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.textIsValid ? 1.0 : 0.0)
                    }
                    .font(.title)
                    
                    .padding(.trailing)
                    ,alignment: .trailing
                )
            
            Button(action: {
                
            }, label: {
                Text("Button")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
                    .cornerRadius(15)
                    .opacity(vm.showButton ? 1.0 : 0.5)
            })
            .disabled(!vm.showButton) // true 之前不能點擊
        }
        .padding()
    }
}

struct SubscriberBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBootcamp()
    }
}
