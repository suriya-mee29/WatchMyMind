//
//  LinkField.swift
//  WatchMyMind
//
//  Created by Suriya on 20/2/2564 BE.
//

import SwiftUI

struct LinkFieldView: View {
    @State private var link : String = ""
    @State private var isEmpty : Bool = true

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center), content: {
            TextField("link to submit", text: $link)
                .padding(.horizontal)
                .frame(height:60)
                .background(Color("backgroung2").opacity(0.2))
                .clipShape(Capsule())
                .onChange(of: link, perform: { value in
                    if value != "" {
                        isEmpty = false
                    }else{
                        isEmpty = true
                    }
                })
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 24))
                    .foregroundColor(Color.white)
                    .frame(width: 60, height: 60)
                    .background(Color("wmm").opacity( isEmpty ? 0.5 : 1.0 ))
                    .clipShape(Capsule())
            })
            .disabled( isEmpty ? true : false )
            /*Image(systemName: "paperplane.fill")
                .font(.system(size: 24))
                .foregroundColor(Color.white)
                .frame(width: 60, height: 60)
                .background(Color("wmm").cornerRadius(9))*/
                
        })
    }
}

struct LinkField_Previews: PreviewProvider {
    static var previews: some View {
        LinkFieldView()
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
