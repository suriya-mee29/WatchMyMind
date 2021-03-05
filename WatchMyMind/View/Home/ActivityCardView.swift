//
//  ActivityCardView.swift
//  WatchMyMind
//
//  Created by Suriya on 1/2/2564 BE.
//

import SwiftUI

struct ActivityCardView: View {
    // MARK: - PROPERTIES
    let activity : Activity
    let progressColor : Color
    let backgroundColor : Color
    // MARK: - BODY
    var body: some View {
        VStack {

            Text(activity.title.uppercased())
                .font(.caption)
                .fontWeight(.bold)
                .lineLimit(2)
                .padding(.horizontal)
                .foregroundColor(Color.black)
                .padding(.bottom)
           
            RingGraphView(value: CGFloat( Int(activity.progrss ) ?? 0 ), color: progressColor)
                
            
          
            
        }
        .frame(width: 155, height: 198, alignment: .center)
        .background(backgroundColor.cornerRadius(30).shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 5))
        
    }
}
     // MARK: -PREVIEW
struct ActivityCardView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCardView(activity:ac[0],
        progressColor: Color("pk2"),
        backgroundColor: Color("gr2"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
