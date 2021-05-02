//
//  ScalingTemporaryView.swift
//  WatchMyMind
//
//  Created by Suriya on 27/4/2564 BE.
//

import SwiftUI

struct ScalingTemporaryView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var action : Int? = 0
    @State var route : [String] = []
    let localRoute : [String]
    @State var results : [String:Any]
    
    let activity : ManualActivitiesModel
    var body: some View {
        VStack {
            Text("let's doing your activity.")
                .font(.headline)
                .fontWeight(.heavy)
                .padding(.top,UIScreen.main.bounds.height * 0.08)
            Image(colorScheme == .dark ? "sand-clock-2" : "sand-clock")
                .resizable()
                .scaledToFit()
                .padding()
            Spacer()
            
            ScrollView(.vertical, showsIndicators: false, content: {
                NavigationLink(
                    destination: ScalingView(isBefore: false, localRoute: self.route,activity: self.activity, results: self.results ) ,
                    tag: NavigationTag.TO_SCALING_VIEW.rawValue,
                    selection: $action,
                    label: {EmptyView()})
            })
            .frame(height : 0)
            
            
            Button(action: {
                if self.route.count != 0 {
                    for i in 0...(self.route.count - 1){
                        if self.route[i] == "scaling"{
                            self.route.remove(at: i)
                            print("remore at temp")
                            print("\(self.route)")
                            action = NavigationTag.TO_SCALING_VIEW.rawValue
                            break
                        }
                    }
                }
              
            }, label: {
                Text("Done")
            })
            .padding()
        }// eof-vstack
        .onAppear(perform: {
            action = 0
            self.route = localRoute
            
        })
    }
}

struct ScalingTemporaryView_Previews: PreviewProvider {
    static var previews: some View {
        ScalingTemporaryView( localRoute: [] , results: [String : Any](), activity:  ManualActivitiesModel(createdby: "", description: "", imageIcon: "", title: "", type: "", everyDay: false, time: 0, round: 0, activityPath: ""))
            
    }
}
