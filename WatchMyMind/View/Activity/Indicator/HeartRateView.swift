//
//  HeartRateView.swift
//  WatchMyMind
//
//  Created by Suriya on 15/2/2564 BE.
//

import SwiftUI
import HealthKit

enum Mode : String{
    case START = "start"
    case STOP = "stop"
}


struct HeartRateView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State private var isAnimated : Bool = false
    @State private var isStart : Bool = false
    @State private var color : Color = Color.green
    @State private var BTNmsg : Mode = Mode.START
    @State private var isDone : Bool = false
    
    var healthStore = HealthStore()
    
    @ObservedObject var stopwatch = Stopwatch()
    
    @State var action : Int? = 0
    @State var route : [String] = []
    let localRoute : [String]
    
    @State var startDate  = Date()
    @State var stopDate  = Date()
    
   
    
    let activity : ManualActivitiesModel
    @State var results : [String:Any]
    
 
   

    
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                NavigationBarViewII(title: "watchmymind", imageIconRight: "")
                    .padding(.horizontal , 15)
                    .padding(.bottom)
                    .padding(.top ,
                             UIApplication.shared.windows.first?.safeAreaInsets.top)
               
                ZStack (alignment: .top){
                    ZStack {
                        Image(systemName: "suit.heart.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.accentColor)
                            .frame(width: 300, height: 300)
                            .scaleEffect( isAnimated  ? 1.0 : 0.7 )
                            .padding(30)
                    }
                    .background(Color("bw"))
                    .clipShape(Circle())
                    .zIndex(1.0)
                    
                    VStack{
                       
                        Text(stopwatch.message)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width : UIScreen.main.bounds.width)
                            .padding(.top,200)
                            
                        Button(action: {
                            if stopwatch.isRunning {
                                stopwatch.stop()
                                self.stopDate = Date()
                                //save result
                                var AVGheartRate : Double = -1.0
                                healthStore.getAVGHeartRate(startDate: self.startDate, endDate: self.stopDate) { statistic in
                                    if let quantity = statistic?.averageQuantity(){
                                        
                                        let beats: Double? = quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
                                        AVGheartRate = beats ?? -1.0
                                       
                                        self.results["AVGheartRate"] = AVGheartRate
                                        self.results["timeInterval"] = stopwatch.tmInterval
                                        
                                    }
                                    
                                }
                                if localRoute.count != 0 {
                                for i in 0...(self.route.count - 1 ){
                                    let tag = getTag(navigationTag: self.route[i])
                                    if route[i] == "scaling"{
                                        if action! < tag {
                                            action = NavigationTag.TO_SCALING_VIEW.rawValue
                                        }
                                    }
                                    if route[i] == "noting"{
                                        if action! < tag {
                                            action = NavigationTag.TO_NOTING_VIEW.rawValue
                                        }
                                    }
                                    
                                    
                                }
                                    for i in 0...(self.route.count - 1 ){
                                        if action == getTag(navigationTag: self.route[i]){
                                            self.route.remove(at: i)
                                            print("removed")
                                            break
                                        }
                                    }
                                }else{
                                  
                                    if activity.outcomeReq.count < 0{
                                        
                                        action = NavigationTag.UPLOADING.rawValue
                                    }else{
                                        //ending
                                        if activity.outcomeReq.count != 0 {
                                            action = NavigationTag.UPLOADING.rawValue
                                            
                                        }else{
                                            //end
                                             action = 0
                                            
                                            

                                        }
                                        //eof - ending
                                    }
                                }
                                
                                
                            } else {
                                stopwatch.start()
                                self.startDate = Date()
                            }
                            if isStart && !isDone{
                                color = Color.green
                                BTNmsg = .START
                                
                            }else{
                                BTNmsg = .STOP
                                color = Color.red
                                isDone = true
                                // nivigate to anther view
                                
                                
                            }
                            isStart = true
                           
                        }, label: {
                            Text(BTNmsg.rawValue.uppercased())
                                .foregroundColor(.white)
                                .font(.title2)
                        })
                        .padding()
                        .background(
                            color
                                .cornerRadius(20))
                        .background(
                            RoundedRectangle(cornerRadius: 20).stroke(Color.gray,lineWidth: 1)
                        )
                        
                     
                        Spacer()
                        ScrollView(.vertical, showsIndicators: false, content: {
                            //afetr scaling view
                            NavigationLink(
                                destination: ScalingView(isBefore: false, localRoute: self.route,activity: self.activity, results: self.results),
                                tag: NavigationTag.TO_SCALING_VIEW.rawValue,
                                selection: $action,
                                label: {EmptyView()})
                            // noting view
                            NavigationLink(
                                destination: NotingView(results: self.results, activity: self.activity),
                                tag: NavigationTag.TO_NOTING_VIEW.rawValue,
                                selection: $action,
                                label: {EmptyView()})
                            //ending view
                            NavigationLink(
                                destination: Text("Ending view"),
                                tag: 200,
                                selection: $action,
                                label: {EmptyView()})
                            //UPLOADING
                            NavigationLink(
                                destination: UploadingView(activity: self.activity, results: self.results),
                                tag: NavigationTag.UPLOADING.rawValue,
                                selection: $action,
                                label: {EmptyView()})
                        })
                        .frame(height : 0)
                    }
                    .background(Color("wmm"))
                    .padding(.top,200)

                    
                    
                }
                    
               
                
                
                
                
            }
            .onAppear(perform: {
                self.action = 0
                self.route = localRoute
                withAnimation(!isStart ? Animation.easeIn(duration: 0.5).repeatForever(autoreverses: false) : Animation.default){
                    isAnimated.toggle()
                           
                }
                
                
            })
        } //: ZSTACK
        .ignoresSafeArea(.all,edges: .all)
    }
}
// MARK: -PREVIEW
struct HeartRateView_Previews: PreviewProvider {
    static var previews: some View {
        HeartRateView(localRoute: [], activity: ManualActivitiesModel(createdby: "", description: "", imageIcon: "", title: "", type: "", everyDay: false, time: 0, round: 0, activityPath: ""), results: [String : Any]())
            .preferredColorScheme(.light)
            
    }
}
