//
//  HomeView.swift
//  WatchMyMind
//
//  Created by Suriya on 29/1/2564 BE.
//

import SwiftUI
import Firebase
import BBRefreshableScrollView
import UserNotifications

struct HomeView: View {
    
    // MARK: - PROPERTIES
    @State public var showDescriptionView: Bool = false
    @State var isNewTripPresented = false
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var isAuthen : Bool
    @Binding var user : User
    @Binding var dt : UserModel?
    
    
    @State var ststus : String = "inactive"
    @State var indicator = [String]()
    @ObservedObject var activities : ActivitiesListViewModel
    @ObservedObject var acStorage = ActivityStorage()
    
    let username : String
    
    @State private var navigationId = UUID()
    
    let currentusername: String
    
 
    
    //@State var status = UserDefaults.standard.object(forKey: "status") as ?
    var healthStore = HealthStore()
    let hapicImpact = UIImpactFeedbackGenerator(style: .medium)
    
    init(isAuthen : Binding<Bool> ,user : Binding<User>, dt : Binding<UserModel?>, username : String){
        self._isAuthen = isAuthen
        self._user = user
        self._dt = dt
        self.username = username
        
        self.activities = ActivitiesListViewModel(username: username)
        self.currentusername = username
        
    }
    // MARK: - BODY
    var body: some View {
        
        
        ZStack {
            if ststus == USER_STATUS.ACTIVE.rawValue {
            NavigationView {
                ZStack {
                        VStack (spacing:0){
                            ZStack (alignment: .top){
                                
                                HeaderView( observed: self.$indicator , user: $user, dt: $dt, currentusername: self.currentusername)
                                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5 )
                                    .zIndex(1)
                                
                            }
                            BBRefreshableScrollView { completion in
                                activities.getActivitiesList(){ (success, err)  in
                                     
                                    if success {
                                   print("success")
                                        completion()
                                
                                    }else{
                                        print("error: \(err)")
                                    }
                                    
                                }
                                
                            } content : {
                                ScrollView(.vertical, showsIndicators: false, content: {
                                    //AUTO ACTIVITY
                                    if(activities.autoActivities!.count > 0){
                                        Group{
                                            ActivityCardGroupView(type: .AUTO, autoActivitys: activities.autoActivities!)
                                        .padding(.top)
                                        }
                                        
                                    }
                                    //Divider()
                                    //MANUAL
                                    if(activities.manualActivities!.count > 0){
                                        ActivityCardGroupView(type: .MANUAL , manualActivity: activities.manualActivities!)
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
                                            Text(L10n.Placeholder.logout.uppercased())
                                                .fontWeight(.bold)
                                            Image(systemName: "chevron.forward.square")
                                                
                                        }
                                    })
                                   
                                    
                                })

                            }
                          
                            
                            
                        }//: VSTACK
                       .background(Color("bw").ignoresSafeArea(.all,edges: .all))
                    }//: ZSTACK
               
                .ignoresSafeArea(.all , edges: .top)
               
            }//: NAVIGITION
            .id(navigationId)
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("popToRootView"))) { output in
                            navigationId = UUID()
                        }
            .navigationViewStyle(StackNavigationViewStyle())
                
           
            }else{
                VStack {
                    WatingView(status: $ststus, userName: dt?.data.userName ?? usernameCurrentUser)
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
                            Text(L10n.Placeholder.logout.uppercased())
                                .fontWeight(.bold)
                            Image(systemName: "chevron.forward.square")
                                
                        }
                    })
                }
            }
            
        }
        .onAppear(perform: {
           /* let content = UNMutableNotificationContent()
            content.title = "Watch My Mind"
            content.subtitle = "You have activities to do, Lest's do it."
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let req = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                //UNCalendarNotificationTrigger(dateMatching: <#T##DateComponents#>, repeats: <#T##Bool#>)
            UNUserNotificationCenter.current().add(req) */
            
           
            self.activities.getObserved(){ seccess , indicator in
                if seccess{
                    self.indicator = indicator
                }
                
            }
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
        HomeView(isAuthen: .constant(true), user: .constant(User()), dt: .constant(UserModel(timestamp: 2, status: true, message: "ok", data: DataUserModel(type: "std", statusid: "12", statusname: "ok", userName: "name", prefixname: "Mr.", displayname_th: "th", displayname_en: "en", email: "mail", department: "str", faculty: "str"))), username: "6009650026")
            .preferredColorScheme(.light)
    }
}
