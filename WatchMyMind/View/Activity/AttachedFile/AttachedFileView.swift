//
//  AttachedFileView.swift
//  WatchMyMind
//
//  Created by Suriya on 23/4/2564 BE.
//

import SwiftUI

struct AttachedFileView: View {
    let photoString : String
    let linkString : String
    var body: some View {
        ZStack {
            VStack (alignment: .leading){
                NavigationBarViewII(title: "watchmymind", imageIconRight: "")
                    .padding(.horizontal , 15)
                    .padding(.bottom)
                    .padding(.top ,
                             UIApplication.shared.windows.first?.safeAreaInsets.top)
                Text("Activity file")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    
                    
                    .foregroundColor(.accentColor)
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack (alignment: .center){
                        if linkString != "" {
                           if let url = URL(string: linkString){
                            HStack {
                                Spacer()
                                LinkCell(url: url)
                                       .frame(width: 300)
                                       //.padding(.bottom ,100)
                                    .padding(.top)
                                Spacer()
                            }
                           }
                        }// eof -- photoURl
                       if photoString != "" {
                           if let url = URL(string: photoString){
                               AsyncImage(url: url) {
                                   HStack {
                                    Spacer()
                                       ProgressView()
                                       Text(" loading")
                                           .font(.footnote)
                                           .fontWeight(.bold)
                                           .foregroundColor(.secondary)
                                    Spacer()
                                   }
                               }
                               .padding(.horizontal)
                           }
                       }
                    }
                }).padding(.top)
                .padding(.horizontal)
                
            }
           
        }.ignoresSafeArea(.all , edges: .top)
        
    }
}

struct AttachedFileView_Previews: PreviewProvider {
    static var previews: some View {
        AttachedFileView(photoString: "https://firebasestorage.googleapis.com/v0/b/watchmymind-9a4de.appspot.com/o/attachedFiles%2F9565BEE7-C227-4CDD-8A87-1D1E2086959C.jpg?alt=media&token=4f0d8d8f-f36a-4358-8615-aacb372e7581"
            , linkString: "https://www.youtube.com/watch?v=e-ORhEE9VVg&list=RD0EVVKs6DQLo&index=27")
    }
}
