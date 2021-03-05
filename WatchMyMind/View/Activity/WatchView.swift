//
//  WatchView.swift
//  WatchMyMind
//
//  Created by Suriya on 26/2/2564 BE.
//

import SwiftUI

struct WatchView: View {
    // MARK: - PROPERTIES
    @State private var annimation : Double = 0.0
    // MARK: - BODY
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.accentColor)
                .frame(width: 120, height: 120, alignment: .center)
            
            Circle()
                .stroke(Color.accentColor, lineWidth: 2)
                .frame(width: 120, height: 120, alignment: .center)
                .scaleEffect(1 + CGFloat(annimation))
                .opacity(1 - annimation)
            
            Image(systemName: "applewatch.watchface")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 90, height: 90, alignment: .center)
                
        } //: ZSTACK
        .onAppear(){
            withAnimation(Animation.easeOut(duration: 1).repeatForever(autoreverses: false)){
                annimation = 1
            }
    }
}
}
    // MARK: -PREVIEW
struct WatchView_Previews: PreviewProvider {
    static var previews: some View {
        WatchView()
            
    }
}

