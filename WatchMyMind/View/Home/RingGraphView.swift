//
//  RingGraphView.swift
//  WatchMyMind
//
//  Created by Suriya on 2/2/2564 BE.
//

import SwiftUI


struct RingGraphView: View {
    // MARK: - PROPERTIES
    
   @State var progess : CGFloat = 0
    let value : CGFloat
    let color : Color
    
    
    // MARK: - BODY
    var body: some View {
    
        ZStack {
            Text("\(Int(value))%")
                .foregroundColor(color)
                .fontWeight(.bold)
                .font(.body)
                .onChange(of: value, perform: { value in
                    withAnimation(Animation.easeIn(duration: 0.7)){
                        progess = value
                    }
                })
            Circle()
                .trim(from: 0, to: 1 )
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .foregroundColor(Color.gray.opacity(0.09))
                
                //.foregroundColor(color.opacity(0.09))
            
            Circle()
                
                .trim(from: 0, to: progess / 100 )
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .foregroundColor(color)
                .onAppear(perform: {
                    withAnimation(Animation.easeIn(duration: 0.7)){
                        progess = value
                    }
                })
                
                
                
        }
        .frame(width: 90, height: 90, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        
    }
}


    // MARK: -PREVIEW
struct RingGraphView_Previews: PreviewProvider {
    static var previews: some View {
        RingGraphView(value: CGFloat(60), color: Color.red)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
