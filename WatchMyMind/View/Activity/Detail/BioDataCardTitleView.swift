//
//  BioDataCardTitleView.swift
//  WatchMyMind
//
//  Created by Suriya on 11/2/2564 BE.
//

import SwiftUI

struct BioDataCardTitleView: View {
    // MARK: - PROPERTIES
    @State private var isAnimated : Bool  = false
    
    let title : String
    let imageIcon : String
    let color : Color
    let value : String
    
    // MARK: - BODY
    var body: some View {
        
        HStack {
            VStack (alignment:.trailing){
                
                    Text(title.uppercased())
                        .foregroundColor(color)
                        .font(.title2)
                        .fontWeight(.medium)
                
                Text(value)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }//: VTACK
            Image(systemName: imageIcon)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.25)
                .padding()
                .foregroundColor(color)
                .scaleEffect(isAnimated ? 1.0 : 0.95 )
        }//: HSTACK
        .onAppear(perform: {
            withAnimation(Animation.easeIn(duration: 0.3).repeatForever(autoreverses: false)){
                isAnimated.toggle()
            }
        })
        
        
    }
}
// MARK: -PREVIEW
struct BioDataCardTitleView_Previews: PreviewProvider {
    static var previews: some View {
        BioDataCardTitleView(title: "BREATHING", imageIcon: "lungs", color: Color("wmm"), value: "5 minutes")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
