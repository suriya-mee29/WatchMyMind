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
    
    @State var route : [String] = []
    let  localRoute : [String]
    @State  var action: Int? = 0
    let activity : ManualActivitiesModel
    @State var results : [String:Any]

    
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
                
                HStack{
                    Spacer()
                    Button(action:{
                        var ac = 0
                        for i in 0...(self.route.count - 1) {
                            let tag = getTag(navigationTag: self.route[i])
                            if self.route[i] == "scaling" {
                                
                                if ac < tag {
                                // go to scaling view
                                ac = NavigationTag.TO_SCALING_VIEW.rawValue
                                }
                                
                            }
                            if self.route[i] == "hr"{
                                if ac < tag {
                                // go to heard rate and timer view
                                ac = NavigationTag.TO_HEART_RATE_AND_TIMER_VIEW.rawValue
                                }
                                
                            }
                            if self.route[i] == "noting" {
                                if ac < tag {
                                // go to noting  view
                                ac = NavigationTag.TO_NOTING_VIEW.rawValue
                                }
                            
                            }
                        } // loop
                        print("action tag \(action)")
                        for i in 0...(self.route.count - 1 ){
                            if ac == getTag(navigationTag: self.route[i]){
                                self.route.remove(at: i)
                                print("removed")
                                break
                            }
                        }
                        print("after remove in attached\(self.route)")
                        self.action = ac
                        //gggggg
                        
                    },label:{
                        Image(systemName: "chevron.forward")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 100)
                            

                    })
                    .background(Color("wmm"))
                    .clipShape(Capsule())
                    Spacer()
                }
                ScrollView(.vertical, showsIndicators: false, content: {
                    // All populatio of indicator
                    //Attached file view
                    // Scalling view
                    NavigationLink(
                        destination: ScalingView(isBefore: true, localRoute: self.route,activity: self.activity, results: self.results),
                        tag: NavigationTag.TO_SCALING_VIEW.rawValue,
                        selection: $action,
                        label: {EmptyView()})
                    //Heart rate and timer view
                    NavigationLink(
                        destination: HeartRateView(localRoute: self.route,activity: self.activity, results: self.results),
                        tag: NavigationTag.TO_HEART_RATE_AND_TIMER_VIEW.rawValue,
                        selection: $action,
                        label: {EmptyView()})
                        .isDetailLink(false)
                    // Nitting view
                    NavigationLink(
                        destination: NotingView(results: self.results, activity: self.activity),
                        tag: NavigationTag.TO_NOTING_VIEW.rawValue,
                        selection: $action,
                        label: {EmptyView()})
                    
                }).frame(height: 0)

                
            }
           
        }.ignoresSafeArea(.all , edges: .top)
        .onAppear(perform: {
            self.action = 0
            self.route = localRoute
            print("app-->\(self.route)")
        })
        
    }
}

struct AttachedFileView_Previews: PreviewProvider {
    static var previews: some View {
        AttachedFileView(photoString: "https://firebasestorage.googleapis.com/v0/b/watchmymind-9a4de.appspot.com/o/attachedFiles%2F9565BEE7-C227-4CDD-8A87-1D1E2086959C.jpg?alt=media&token=4f0d8d8f-f36a-4358-8615-aacb372e7581"
                         , linkString: "https://www.youtube.com/watch?v=e-ORhEE9VVg&list=RD0EVVKs6DQLo&index=27", localRoute:  [], activity: ManualActivitiesModel(createdby: "", description: "", imageIcon: "", title: "", type: "", everyDay: false, time: 0, round: 0, activityPath: ""), results: [String : Any]())
    }
}
