//
//  ContentView.swift
//  WatchMyMind
//
//  Created by Suriya on 27/1/2564 BE.
//

import SwiftUI
import Firebase

struct ContentView: View {
    // MARK: - PROPERTIES
    @State var isAuthen : Bool = statusCurrentUser
    @State private var username : String = ""
    @State private var password : String = ""
    @State var dt : UserModel?
    @ObservedObject var activities : ActivitiesListViewModel
    
    let ar : [AutoActivitiesModel] = [AutoActivitiesModel(createdby: "ww", description: "sss", imageIcon: "play2", title: "test", type: "AUTO", progress: 21, everyDay: true, time: 30, round: 2, NoOfDate: 7),AutoActivitiesModel(createdby: "w222w", description: "s222ss", imageIcon: "play2", title: "test2", type: "AUTO", progress: 21, everyDay: true, time: 30, round: 2, NoOfDate: 7)]
    
    
    @State var user = User()
    @Environment(\.managedObjectContext) private var viewContext
   
    init() {
        self.activities = ActivitiesListViewModel(username: "6009650026")
        
    }
    func getstatus()-> Bool{
        return false
    }

    
    // MARK: - BODY
    var body: some View {
        ZStack{
            
            if isAuthen {
                HomeView(isAuthen: $isAuthen, user: $user, dt: $dt, username: dt?.data.userName ?? usernameCurrentUser ).environment(\.managedObjectContext, viewContext)
                
            }else{
                
                LoginView(isAuthen: $isAuthen, dt: $dt )
                
            }
            
        }.onAppear{
            
        }
            
    }
}

// MARK: -PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
