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
    var manualActivity : ManualActivitiesModel = ManualActivitiesModel(createdby: "", description: "", imageIcon: "", title: "", type: "", everyDay: false, time: 0, round: 0)
    let type : activityType
    let navigationTag : NavigationTag
    
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
                    
                    NavigationLink(
                        destination: //AttachedFileView(photoString: "https://firebasestorage.googleapis.com/v0/b/watchmymind-9a4de.appspot.com/o/attachedFiles%2F9565BEE7-C227-4CDD-8A87-1D1E2086959C.jpg?alt=media&token=4f0d8d8f-f36a-4358-8615-aacb372e7581", linkString: "https://www.youtube.com/watch?v=e-ORhEE9VVg&list=RD0EVVKs6DQLo&index=27")
                        Text("ff")
                        ,
                        tag: NavigationTag.OTHER.rawValue,
                        selection: $action ,
                        label: {EmptyView()})
                    
                    
                    
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
                                
                                for i in 0...(self.router.count-1){
                                    if self.router[i] == "attached"{
                                        // go to attached view
                                        self.router.remove(at: i)
                                        break
                                    }
                                    if self.router[i] == "scaling" {
                                        // go to scaling view
                                        self.router.remove(at: i)
                                        break
                                    }
                                    if self.router[i] == "hr"{
                                        // go to heard rate and timer view
                                        self.router.remove(at: i)
                                        break
                                    }
                                    if self.router[i] == "noting" {
                                        // go to noting  view
                                        self.router.remove(at: i)
                                        break
                                    }
                                }
                                
                                
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
                  //  .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 5)
                    //: Btton
                }
               
                
            }//: ZSTACK
            .ignoresSafeArea(.all , edges: .top)
            .onAppear(perform: {
                self.router = manualActivity.indicator
                if manualActivity.link != "" || manualActivity.photoURL != ""{
                    router.append("attached")
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
