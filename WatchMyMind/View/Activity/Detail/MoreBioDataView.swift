//
//  MoreBioDataView.swift
//  WatchMyMind
//
//  Created by Suriya on 12/2/2564 BE.
//

import SwiftUI

struct MoreBioDataView: View {
    // MARK: - PROPERTIES
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                NavigationBarViewII(title: "watchmymind", imageIconRight: "")
                    .padding(.horizontal , 15)
                    .padding(.bottom)
                    .padding(.top ,
                             UIApplication.shared.windows.first?.safeAreaInsets.top)
                
                HeaderDetailIView(date: "11 November 2020", time: "08:00 - 08:05", location: "Khlong Luang")
                    .padding(.top)
                
                VStack(alignment: .trailing){
                    
                    BioDataCardTitleView(title: "BREATHING", imageIcon: "lungs", color: Color("wmm"), value: "5 minutes")
                        .padding(.top)
                    
                    BioDataCardTitleView(title: "ACTIVE KILOCALORIES", imageIcon: "chevron.right.2", color: Color("wmm"), value: "5 minutes")
                        .padding(.top)
                    
                    BioDataCardTitleView(title: "BREATHING", imageIcon: "heart", color: Color("wmm"), value: "5 minutes")
                        .padding(.top)
                    
                }
                .padding(.top)
                .padding(.horizontal)
                
                Spacer()
                
            }
        }
        .ignoresSafeArea(.all,edges: .all)
    }
}
// MARK: -PREVIEW
struct MoreBioDataView_Previews: PreviewProvider {
    static var previews: some View {
        MoreBioDataView()
            .preferredColorScheme(.light)
    }
}
