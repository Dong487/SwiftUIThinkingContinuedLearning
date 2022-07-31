//
//  TypealiasBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by DONG SHENG on 2021/10/18.
//

import SwiftUI


struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

typealias TVModel = MovieModel

struct TypealiasBootcamp: View {
    
    @State var item: TVModel = TVModel(title: "標題", director: "導演DoNG", count: 6)
    
    var body: some View {
        
        VStack{
            Text(item.title)
            
            Text(item.director)
            
            Text("\(item.count)")
        }
    }
}

struct TypealiasBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TypealiasBootcamp()
    }
}
