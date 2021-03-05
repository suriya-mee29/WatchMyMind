//
//  LinkUploadView.swift
//  WatchMyMind
//
//  Created by Suriya on 18/2/2564 BE.
//

import SwiftUI

struct LinkUploadView: View {
    var body: some View {
        ZStack {
            VStack {
                NavigationBarViewII(title: "watchmymind", imageIconRight: "")
                    .padding(.horizontal , 15)
                    .padding(.bottom)
                    .padding(.top ,
                             UIApplication.shared.windows.first?.safeAreaInsets.top)
                Text("อัพโหลดลิงค์ของหนังที่ดูหรือTrailerของหนัง")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top)
                    .lineLimit(2)
                
                Image(systemName: "square.and.arrow.up")
                     .resizable()
                     .scaledToFit()
                     .frame(width: UIScreen.main.bounds.width * 0.38, height: UIScreen.main.bounds.width * 0.38)
                     .foregroundColor(.accentColor)
                     .padding()
                     .padding(.top, UIScreen.main.bounds.height * 0.02)
                
              LinkFieldView()
                .padding(.horizontal)
                .padding(.top)
                
                Spacer()
                
            }
        }//: ZSTACK
        .ignoresSafeArea(.all,edges: .all)
    }
}

struct LinkUploadView_Previews: PreviewProvider {
    static var previews: some View {
        LinkUploadView()
    }
}
