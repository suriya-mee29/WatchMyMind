//
//  NavigationBarViewII.swift
//  WatchMyMind
//
//  Created by Suriya on 11/2/2564 BE.
//

import SwiftUI

struct NavigationBarViewII: View {
    // MARK: - PROPERTIES
    var title : String
    var imageIconRight : String
    // MARK: - BODY
    var body: some View {
        ZStack {
            HStack(alignment: .center){
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "arrow.backward")
                        .font(.title)
                         .foregroundColor( Color("backgroung2"))
                        
                })
                .hidden()
            
                Spacer()
                Text(title.uppercased())
                    .foregroundColor(Color("backgroung2"))
                    .fontWeight(.bold)
                    .font(.headline)
                Spacer()
                
                if(imageIconRight == ""){
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        
                        Image(systemName: "arrow.backward" )
                            .font(.title)
                             .foregroundColor( Color("backgroung2"))
                    })
                    .hidden()
                    
                }else{
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        
                        Image(systemName: imageIconRight)
                            .font(.title)
                             .foregroundColor( Color("backgroung2"))
                    })
                    .hidden()
                    
                }
                
                
                
                
            }// :HSTACK
            
        }//: ZSTACK
       

    }
}
    // MARK: -PREVIEW
struct NavigationBarViewII_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarViewII(title: "watchmymind", imageIconRight: "")
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
