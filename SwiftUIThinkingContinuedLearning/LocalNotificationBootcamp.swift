//
//  LocalNotificationBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/4.
//

import SwiftUI
import UserNotifications
import CoreLocation


// 三種情況可以觸發 通知
// 1. 時間    2. 日期     3.位置


// 1) 向用戶請求授權 (通知)
// 2) 依照條件觸發 發送通知 (應用程式必須最小化或在背景程式 才會發送)
// 3) 取消刪除通知

class NotificationManager{
    
    static let instance = NotificationManager()
    
    // 向用戶請求授權
    func requestAuthorization(){
        // 選項:  授權的項目 = [提示 , 聲音 , 圖像標記]
        let options :UNAuthorizationOptions = [.alert , .sound , .badge]
        //
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            // error 是可選的(?)
            if let error = error {
                print("(授權失敗)錯誤 : \(error)")
            } else {
                print("授權成功！ \(success)")
            }
        }
    }
    
    // 行程通知
    func scheduleNotification(){
        // 內容 = 不可變的內容通知
        let content = UNMutableNotificationContent()
        content.title = "我是第ㄧ個通知title "
        content.subtitle = "賽鴿 速度快得像是F1賽車"
        content.sound = .default
        content.badge = 1   // 應用程式右上方 的 紅圈圈通知數
        
    // 1) Time 時間 觸發
    // timeInterval 時間間隔: 單位(秒)
    // repeats 重複 : false (否)
    // 假如要 重複(repeats: true) , 時間間隔最少要 60s 不然會崩潰
        let TimeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 6.0, repeats: false)
        
    // 2) Calendar 日期 觸發
        //  先設定日期 小時 分
        //
        var dateComponents = DateComponents()
        dateComponents.hour = 6
        dateComponents.minute = 44
        // 每個禮拜中 的某一天
        // 1 = 星期日  2 = 星期一 ..... 7 = 星期六
        dateComponents.weekday = 2
        
        let CalendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

    // 3) Location 位置 觸發

        // 中心點座標
        let coordinates = CLLocationCoordinate2D(
            latitude: 23.563234,    // 緯度
            longitude: 120.5825975) // 經度
        
        // CLCircularRegion() -> 一個圓形範圍
        let region = CLCircularRegion(
            center: coordinates, // 中心點座標
            radius: 100, // 半徑 以 米為單位
            identifier: UUID().uuidString)
        region.notifyOnEntry = true // 進入(圓圈範圍)時發通知
        region.notifyOnExit = true // 離開(圓圈範圍)時 也發通知
        let LocationTrigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        
        
        let request = UNNotificationRequest(
            // identifier 辨識碼：  隨機
            identifier: UUID().uuidString,
            // content 內容
            content: content,
            // trigger 觸發 :
            trigger: CalendarTrigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    // 取消刪除通知
    func cancelNotification(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40){
            
            Button("許可請求"){
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("通知逼逼逼"){
                NotificationManager.instance.scheduleNotification()
            }
        }
        .onAppear{
            // 當你點進 App 裡面後 桌面顯示的數字歸0 (紅圈圈就會消失)
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotificationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationBootcamp()
    }
}
