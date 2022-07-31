//
//  TimerBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/20.
//

import SwiftUI

struct TimerBootcamp: View {
    //  Timer.publish  以時間為基礎  發布者
    // every: 每幾秒, on: 用哪個線程, in: .common)
    // .autoconnect() 螢幕出現後自動連接 這項功能
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
   
    // 當前的時間
    /*
    @State var currentDate: Date = Date()
    // 更改日期的 樣式
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        return formatter
    }*/
    
    // 倒數計時
    /*
    @State var count: Int = 10
    @State var finishedText: String? = nil
     */
    
    // 利用實際日期 做倒數 (優化:倒數至個位數時 十位數補個0)
    /*
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining(){
        // 計算 今天日期(from:) 到 所設定未來日期(to:) 的 剩餘時間
        let remaining = Calendar.current.dateComponents([.hour, .minute , .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hour):\(minute):\(second)"
    }*/
    
    
    @State var count: Int = 0
    var body: some View {
        ZStack{
            RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)), Color(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1))]),
                           center: .center,
                           startRadius: 5,
                           endRadius: 500)
            HStack(spacing: 15){
                Circle()
                    .offset(y: count == 1 ? -30 : 0)
                Circle()
                    .offset(y: count == 2 ? -30 : 0)
                Circle()
                    .offset(y: count == 3 ? -30 : 0)
                
            }
            .foregroundColor(.white)
   //         Text(dateFormatter.string(from: currentDate))
//            Text(timeRemaining)
//                .font(.system(size: 100, weight: .semibold, design: .rounded))
//                .foregroundColor(.white)
//                .lineLimit(1) // 一行內顯示
//                .minimumScaleFactor(0.1)
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.easeInOut(duration: 0.5)){
                count = count == 3 ? 0 : count + 1
            }
        })
//        .onReceive(timer, perform: { _ in
//            updateTimeRemaining()
//        })
        
        // value 會根據接受的內容不同 而不一樣  Maybe: data、date
        // 倒數計時
//        .onReceive(timer, perform: { value in
//            if count <= 1 {
//                finishedText = "HAPPY NEW YEARS"
//            } else {
//                count -= 1
//            }
//        })
    }
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
