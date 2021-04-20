//
//  HomeView.swift
//  WatchMyMind
//
//  Created by Suriya on 29/1/2564 BE.
//

import SwiftUI
import HealthKit
import Firebase

struct HomeView: View {
    
    // MARK: - PROPERTIES
    @ObservedObject var activityVM = ActivityViewModel()
    @State public var showDescriptionView: Bool = false
    @State var isNewTripPresented = false
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @Binding var isAuthen : Bool
    @Binding var user : User
    @Binding var dt : UserModel?
    
    @State var ststus : String = "inactive"
    
    
    
    
    //@State var status = UserDefaults.standard.object(forKey: "status") as ?
    var healthStore = HealthStore()
    let hapicImpact = UIImpactFeedbackGenerator(style: .medium)
    // MARK: - BODY
    var body: some View {
        
        
        ZStack {
            if ststus == USER_STATUS.ACTIVE.rawValue {
            NavigationView {
                ZStack {
                        VStack (spacing:0){
                            ZStack (alignment: .top){
                                
                                HeaderView( user: $user, dt: $dt)
                                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5 )
                                    .zIndex(1)
                                
                            }
                            ScrollView(.vertical, showsIndicators: false, content: {
                                //AUTO ACTIVITY
                                if(ac.count > 0){
                                    Group{
                                    ActivityCardGroupView(type: .AUTO , activitys: activityVM.activitys)
                                    .padding(.top)
                                    }
                                    
                                }
                                //Divider()
                                //AUTO
                                if(ac.count > 0){
                                ActivityCardGroupView(type: .MANUAL , activitys: ac2)
                                    .padding(.top)
                                }
                                Button(action: {
                                    do {
                                      try Auth.auth().signOut()
                                        isAuthen = false
                                        let userDefults = UserDefaults.standard
                                        do {
                                            var userData = try userDefults.getObject(forKey: "userData", castTo: UserModel.self)
                                            if userData != nil {
                                                userData.status = false
                                                try userDefults.setObject(userData, forKey: "userData")
                                                print("save user data")
                                            }

                                        } catch {
                                            print(error.localizedDescription)
                                        }
                                        
                                    } catch{
                                        print("\(error.localizedDescription)")
                                        
                                    }
                                    
                                }, label: {
                                    HStack {
                                        Text("logout".uppercased())
                                            .fontWeight(.bold)
                                        Image(systemName: "chevron.forward.square")
                                            
                                    }
                                })
                               
                                
                            })
                            
                            
                        }//: VSTACK
                       .background(Color("bw").ignoresSafeArea(.all,edges: .all))
                    }//: ZSTACK
               
                .ignoresSafeArea(.all , edges: .top)
            }//: NAVIGITION
            }else{
                WatingView(status: $ststus, userName: dt?.data.userName ?? usernameCurrentUser)
            }
            
        }
        .onAppear(perform: {
            user.getUserSatus(username: dt?.data.userName ?? usernameCurrentUser){ status in
                self.ststus = status
                print(status)
                
            }
    })
       
       
}
}
   // MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(isAuthen: .constant(true), user: .constant(User()), dt: .constant(UserModel(timestamp: 2, status: true, message: "ok", data: DataUserModel(type: "std", statusid: "12", statusname: "ok", userName: "name", prefixname: "Mr.", displayname_th: "th", displayname_en: "en", email: "mail", department: "str", faculty: "str"))))
            .preferredColorScheme(.light)
    }
}
