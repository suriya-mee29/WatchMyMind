//
//  DescriptionView.swift
//  WatchMyMind
//
//  Created by Suriya on 3/2/2564 BE.
//

import SwiftUI

struct DescriptionView: View {
    // MARK: - PROPERTIES
    @State private var isAnnimatingImage : Bool = false
    var activity : AutoActivitiesModel =   AutoActivitiesModel(createdby: "", description: "", imageIcon: "", title: "", type: "", progress: 21, everyDay: true, time: 0, round: 0, NoOfDate: 0)
    var manualActivity : ManualActivitiesModel = ManualActivitiesModel(createdby: "", description: "", imageIcon: "", title: "", type: "", everyDay: false, time: 0, round: 0, activityPath: "")
    let type : activityType
    let navigationTag : NavigationTag
    @State var results : [String:Any] = [String:Any]()

    
    
    @Environment(\.managedObjectContext) private var viewContext
    @State  var action: Int? = 0
    @State var isDate : Bool = false
    
    
    // ROUTER
    @State var router : [String] = []
    
    
    
    
    // MARK: - BODY
    var body: some View {
            ZStack{
                VStack {
                    NavigationBarViewII(title: "watchmymind", imageIconRight: "")
                        .padding(.horizontal , 15)
                        .padding(.bottom)
                        .padding(.top ,
                                 UIApplication.shared.windows.first?.safeAreaInsets.top)
                    Image( type == activityType.AUTO ?  activity.imageIcon: manualActivity.imageIcon)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color("wmm"))
                        .frame(width: 250, height: 250, alignment: .center)
                        .padding(.top , UIScreen.main.bounds.height * 0.05)
                        .scaleEffect(isAnnimatingImage ? 1.0 : 0.6)
                        .onAppear(){
                            withAnimation(.easeOut(duration: 0.5)){
                                isAnnimatingImage = true
                            }
                        }
                        .onDisappear(perform: {
                            isAnnimatingImage = false
                        })
                       
                    ScrollView(.vertical, showsIndicators: false, content: {
                        Text(type == activityType.AUTO ? activity.title.uppercased() : manualActivity.title.uppercased())
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(Color("wmm"))
                       
                            
                        Text(type == activityType.AUTO ? activity.description : manualActivity.description)
                                .font(.body)
                                .padding(.horizontal , UIScreen.main.bounds.width * 0.1)
                                .foregroundColor(.gray)
                                .padding(.top,5)
                        
                        
                        
                        VStack (alignment: .center){
                            Text(type == activityType.AUTO ? (activity.everyDay ? "Every day": "Someday, at least \(activity.NoOfDate) days" )
                                    
                                    
                                    :(manualActivity.everyDay ? "Every day": "Someday,at least \(manualActivity.NoOfDate) days" ))
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(Color("stand"))
                                .padding(.top,5)

                            VStack(alignment:.leading){
                                if type == activityType.AUTO{
                                    if activity.time > 0 {
                                        HStack {
                                            Image(systemName: "clock")
                                                .foregroundColor(Color("stand"))
                                            Text("\(activity.time) Mins/Day")
                                                .font(.system(size: 16))
                                                .fontWeight(.bold)
                                                .foregroundColor(Color("stand"))
                                                .padding(.top,5)
                                        }
                                    }
                                    if activity.round > 0{
                                        HStack {
                                            Image(systemName: "arrow.clockwise")
                                                .foregroundColor(Color("stand"))
                                            Text("\(activity.round) Time/Day")
                                                .font(.system(size: 16))
                                                .fontWeight(.bold)
                                                .foregroundColor(Color("stand"))
                                                .padding(.top,5)
                                        }
                                    }
                                    
                                }else{
                                    if manualActivity.time > 0 {
                                        HStack {
                                            Image(systemName: "clock")
                                                .foregroundColor(Color("stand"))
                                            Text("\(manualActivity.time) Mins/Day")
                                                .font(.system(size: 16))
                                                .fontWeight(.bold)
                                                .foregroundColor(Color("stand"))
                                                .padding(.top,5)
                                        }
                                    }
                                    if manualActivity.round > 0{
                                        HStack {
                                            Image(systemName: "arrow.clockwise")
                                                .foregroundColor(Color("stand"))
                                            Text("\(manualActivity.round) Time/Day")
                                                .font(.system(size: 16))
                                                .fontWeight(.bold)
                                                .foregroundColor(Color("stand"))
                                                .padding(.top,5)
                                        }
                                    }
                                    
                                }
                            }
                            
                          
                        }
                    })
                    .padding(.bottom)
                  Spacer()
                    ScrollView(.vertical, showsIndicators: false, content: {
                        NavigationLink(destination:
                                        BioDataListView(headline: "BREATHING", isActivity: false)
                            .environment(\.managedObjectContext, viewContext)
                                       , tag: NavigationTag.TO_BIODATA_VIEW.rawValue, selection: $action){
                            EmptyView()
                            
                        }
                        NavigationLink(destination:
                                        BioDataListView(headline: "EXERCISE", isActivity: true)
                            .environment(\.managedObjectContext, viewContext)
                                       , tag: 2, selection: $action){
                            EmptyView()
                            
                        }
                        // All populatio of indicator
                        //Attached file view
                        NavigationLink(
                            destination: AttachedFileView(photoString: manualActivity.photoURL, linkString: manualActivity.link, localRoute: self.router, activity: self.manualActivity, results: self.results),
                            tag: NavigationTag.TO_ATTACHED_VIEW.rawValue,
                            selection: $action ,
                            label: {EmptyView()})
                            .isDetailLink(false)
                        // Scalling view
                        NavigationLink(
                            destination: ScalingView(isBefore: true, localRoute: self.router,activity: self.manualActivity, results: self.results),
                            tag: NavigationTag.TO_SCALING_VIEW.rawValue,
                            selection: $action,
                            label: {EmptyView()})
                        //Heart rate and timer view
                        NavigationLink(
                            destination: HeartRateView(localRoute: self.router, activity: self.manualActivity, results: self.results),
                            tag: NavigationTag.TO_HEART_RATE_AND_TIMER_VIEW.rawValue,
                            selection: $action,
                            label: {EmptyView()})
                        // Nitting view
                        NavigationLink(
                            destination: NotingView( results: self.results, activity: self.manualActivity),
                            tag: NavigationTag.TO_NOTING_VIEW.rawValue,
                            selection: $action,
                            label: {EmptyView()})
                        
                    }).frame(height: 0)
                    
                    
                    //START BTN
                    Button(action: {
                        self.action = navigationTag.rawValue
                        if action == NavigationTag.TO_BIODATA_VIEW.rawValue {
                            if activity.title == "Exercise" {
                                self.action = 2
                            }else{
                                // not do something
                            }
                        }else{
                            // manual activity router
                            if type == .MANUAL {
                                let result : [String:Any] = ["startDate":Date()]
                                self.results = result
                                for i in 0...(self.router.count-1){
                                    let tag = getTag(navigationTag: self.router[i])
                                    if self.router[i] == "attached"{
                                            
                                        if action! < tag {
                                        // go to attached view
                                        self.action = NavigationTag.TO_ATTACHED_VIEW.rawValue
                                        }
                                    }
                                    if self.router[i] == "scaling" {
                                        
                                        if action! < tag {
                                        // go to scaling view
                                        self.action = NavigationTag.TO_SCALING_VIEW.rawValue
                                        }
                                        
                                    }
                                    if self.router[i] == "hr"{
                                        if action! < tag {
                                        // go to heard rate and timer view
                                        self.action = NavigationTag.TO_HEART_RATE_AND_TIMER_VIEW.rawValue
                                        }
                                        
                                    }
                                    if self.router[i] == "noting" {
                                        if action! < tag {
                                        // go to noting  view
                                        self.action = NavigationTag.TO_NOTING_VIEW.rawValue
                                        }
                                    
                                    }
                                    if self.router[i] == "reqPhoto"{
                                        if action! < tag {
                                        // go to uploading image  view
                                            self.action = NavigationTag.TO_IMAGE_UPLAOD_VIEW.rawValue
                                        
                                        }
                                    }
                                    if self.router[i] == "reqLink"{
                                        if action! < tag {
                                        // go to uploading link  view
                                            self.action = NavigationTag.TO_IMAGE_UPLAOD_VIEW.rawValue
                                        
                                        }
                                    }
                                }
                                
                                print("action tag \(action)")
                                for i in 0...(self.router.count - 1 ){
                                    if action == getTag(navigationTag: self.router[i]){
                                        self.router.remove(at: i)
                                        print("removed")
                                        break
                                    }
                                }
                                print("after remove \(self.router)")
                                //gggggg
                                
                                
                                
                            }
                            
                        }
                        
                    }, label: {
                        HStack{
                            Text("start".uppercased())
                                .fontWeight(.bold)
                                .padding()
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                    })
                    .background(Color("wmm"))
                    .clipShape(Capsule())
                 
                    //: eof-Btton
                }//: eof - VStack
               
                
            }//: ZSTACK
            .ignoresSafeArea(.all , edges: .top)
            .onAppear(perform: {
                if type == .MANUAL {
                self.router = manualActivity.indicator
                    print("router-->\(self.router)")
                    if manualActivity.link != "" || manualActivity.photoURL != ""{
                        self.router.append("attached")
                    }
                    print("app \(self.router)")
                }
            })
        }
    }
// MARK: -PREVIEW
struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(activity: AutoActivitiesModel(createdby: "ss", description: "Exercises, including jogging, swimming, cycling, walking, gardening, and dancing, have been proved to reduce anxiety and depression. These improvements in mood are proposed to be caused by exercise-induced increase in blood circulation to the brain and by an influence on the hypothalamic-pituitary-adrenal(HPA) axis and, thus, on the physiologic reactivity to stress", imageIcon: "play2", title: "hello", type: activityType.AUTO.rawValue, progress: 30, everyDay: true, time: 30, round: 2, NoOfDate: 6), type: activityType.AUTO, navigationTag: NavigationTag.TO_BIODATA_VIEW)
            
    }
}
