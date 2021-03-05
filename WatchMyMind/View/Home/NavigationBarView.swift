//
//  NavigationBarView.swift
//  WatchMyMind
//
//  Created by Suriya on 29/1/2564 BE.
//

import SwiftUI

struct NavigationBarView: View {
    // MARK: - PROPERTIES
    // MARK: - BODY
    var body: some View {
        HStack{
            Spacer()
            Button(action:{} , label : {
                Image(systemName: "arrow.right.square")
                    .font(.title)
                    .foregroundColor(Color.gray)
                    
            }) //BUTTON
            .padding()
            
        }// :HSTACK
    }
}
// MARK: -PREVIEW
struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
