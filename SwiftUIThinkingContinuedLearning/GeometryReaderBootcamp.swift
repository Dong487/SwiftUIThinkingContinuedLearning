//
//  GeometryReaderBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/3.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    
    func getPercentage(geo: GeometryProxy) -> Double{
        // 最大距離 螢幕寬度 / 2
        let maxDistance = UIScreen.main.bounds.width / 2
        // 目前的 x = 卡片的中點座標 x軸 (in: 在整個螢幕)
        let currentX = geo.frame(in: .global).midX
        
        return Double(1 - (currentX / maxDistance))
    }
    
    
    
    var body: some View {
        
        VStack {
          
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack{
                    ForEach(0..<20) { index in
                        GeometryReader{ geometry in
                            ZStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .rotation3DEffect(
                                        Angle(degrees: getPercentage(geo: geometry) * 40),
                                        axis: (x: 0.0, y: 1.0, z: 0.0)
                                        
                                )
                                VStack {
                                    Text("角度:\(getPercentage(geo: geometry) * 40)")
                                        .font(.largeTitle)
                                        .foregroundColor(.yellow)
                                    
                                    Text("卡片的中點座標 x :\(geometry.frame(in: .global).midX)")
                                        .font(.largeTitle)
                                        .foregroundColor(.pink)
                                }
                            }
                        }
                        .frame(width: 350, height: 250)
                        .padding()
                    }
                }
            })
        }
        
//        GeometryReader{ geometry in
//            HStack(spacing: 0){
//                Rectangle()
//                    .fill(Color.yellow)
//                    .frame(width: geometry.size.width * 0.666)
//                Rectangle()
//                    .fill(Color.green)
//            }
//            .ignoresSafeArea()
//        }
    }
}

struct GeometryReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderBootcamp()
    }
}
