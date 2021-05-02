//
//  LinkField.swift
//  WatchMyMind
//
//  Created by Suriya on 20/2/2564 BE.
//

import SwiftUI

struct LinkFieldView: View {
    @Binding  var link : String
   

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center), content: {
            TextField("link to submit", text: $link)
                .padding(.horizontal)
                .frame(height:60)
                .background(Color("backgroung2").opacity(0.2))
                .clipShape(Capsule())
               
            
           
                
        })
    }
}

struct LinkField_Previews: PreviewProvider {
    static var previews: some View {
        LinkFieldView(link: .constant(""))
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
