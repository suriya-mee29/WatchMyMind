//
//  ScalingTemporaryView.swift
//  WatchMyMind
//
//  Created by Suriya on 27/4/2564 BE.
//

import SwiftUI

struct ScalingTemporaryView: View {
    let photoString : String
    let linkString : String
    @Environment(\.colorScheme) var colorScheme
    @State var action : Int? = 0
    @State var route : [String] = []
    let localRoute : [String]
    @State var results : [String:Any]
    @State  var showAttchedFile : Bool = false
    
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
            if self.photoString != "" || self.linkString != ""{
                ZStack {
                    Button(action: {
                    self.showAttchedFile.toggle()
                }, label: {
                    HStack {
                        Image(systemName: "filemenu.and.cursorarrow")
                            .font(.title3)
                        Text("activity file".uppercased())
                            .font(.title3)
                            .fontWeight(.bold)
                          
                    }
                })
                    .padding()
                   
                }
                .background(
                    RoundedRectangle(cornerRadius: 12).stroke(Color("wmm"),lineWidth: 2))
            }
            Spacer()
            
            ScrollView(.vertical, showsIndicators: false, content: {
                NavigationLink(
                    destination: ScalingView(photoString : self.photoString ,linkString : self.linkString , isBefore: false, localRoute: self.route,activity: self.activity, results: self.results ) ,
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
                            self.results["endDate"] = Date()
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
        .sheet(isPresented: self.$showAttchedFile, content: {
            AttachedFileView(photoString: self.photoString, linkString: self.linkString, isNext: false, localRoute: [], activity: ManualActivitiesModel(createdby: "", description: "", imageIcon: "", title: "", type: "", everyDay: false, time: 0, round: 0, activityPath: "", observedPath: "", startDate: Date(), endDate: Date()), results: [String : Any]())
        })
    }
}

struct ScalingTemporaryView_Previews: PreviewProvider {
    static var previews: some View {
        ScalingTemporaryView( photoString : "" , linkString : "https://www.youtube.com/watch?v=7bkHtMw620M" ,localRoute: [] , results: [String : Any](), activity:  ManualActivitiesModel(createdby: "", description: "", imageIcon: "", title: "", type: "", everyDay: false, time: 0, round: 0, activityPath: "", observedPath: "",startDate: Date(),endDate:Date()))
            
    }
}
