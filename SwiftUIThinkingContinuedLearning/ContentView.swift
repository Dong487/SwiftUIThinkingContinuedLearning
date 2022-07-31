//
//  ContentView.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/9/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var angle: Angle = Angle(degrees: 0)
    @State var angleText: Double = 0
    
    var body: some View {
        Text("\(angleText)")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(50)
            .background(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)).cornerRadius(15))
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged{ value in
                        angle = value
               //         angleText = value
                    }
                    .onEnded{ value in
                        withAnimation(.spring()){
                            angle = Angle(degrees: 0)
                        }
                    }
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
