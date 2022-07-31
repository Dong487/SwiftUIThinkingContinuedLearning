//
//  SoundsBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/3.
//

import SwiftUI
import AVKit

class SoundManager{
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String{
        case SS1
        case shaverHair
    }
    
    
    func playSound(sound: SoundOption){
        // 從 資料夾中獲取檔案 (檔案名稱  , 檔案類型)
        // Bundle.main.url(forResource: "SS1", withExtension: ".mp3")
        
        // 從網址內獲取檔案
        // URL(string: "")
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do{
            player = try AVAudioPlayer(contentsOf: url) // 嘗試從 url 獲取音檔 至 AVAudioPlayer
            player?.play()
        }catch let error {
            print("播放音檔時發生錯誤... 描述: \(error.localizedDescription)")
        }
        
    }
}


struct SoundsBootcamp: View {
    
    var body: some View {
        VStack(spacing: 20){
            Button("播放音樂檔案 ONE"){
                SoundManager.instance.playSound(sound: .SS1)
            }
            Button("播放音樂檔案 TWO"){
                SoundManager.instance.playSound(sound: .shaverHair)

            }
        }
    }
}

struct SoundsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SoundsBootcamp()
    }
}
