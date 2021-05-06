//
//  BioDataListView.swift
//  WatchMyMind
//
//  Created by Suriya on 11/2/2564 BE.
//

import SwiftUI

struct BioDataListView: View {
    // MARK: - PROPERTIES
    let headLine : String
    let isActivity : Bool
    @State var mindfulnessArr = [MindfulnessModel]()
    @ObservedObject var mindfulnessMV : MindfulnessStore
    @ObservedObject var autoActivityStore : AutoActivityStore
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    var MindfulnessCollection : FetchedResults<Mindfulness>
    @State private var isPresented = true
    @State private var hasdone : Int = 0
    let autoActivity : AutoActivitiesModel
    
    
    var healthStore = HealthStore()
    @ObservedObject var avtivityStorage = ActivityStorage()
    
    // MARK: - CONSTRUCTOR
    init(headline: String, isActivity : Bool,autoActivity : AutoActivitiesModel) {
        self.headLine = headline
        mindfulnessMV = MindfulnessStore(MindfulnessArr: [])
        self.isActivity = isActivity
        autoActivityStore = AutoActivityStore(autoActivityCollection: [])
        self.autoActivity = autoActivity
    }
   
    // MARK: - FUNCTION
    private func fetchData(){
        
        var arrMindFul = [MindfulnessModel]()
        healthStore.mindfultime(startDate: Date() , numberOfday: -7) { (samples) in
            
            for sample in samples {
               
                guard  let uuid = sample?.uuid else {return}
                guard let time = sample?.endDate.timeIntervalSince(sample!.startDate) else{return}
                guard let date = sample?.startDate else {return}
                
                let mif  = MindfulnessModel(id: uuid , date: date, time: Int32(time / 60))
                
                arrMindFul.append( mif )
            }
            mindfulnessMV.setMindfulness(newData: arrMindFul)
        }
        healthStore.calculateMindfulTime(startDate: Date(), numberOfday: -7) { (time) in
            self.hasdone = Int(time / 60)
        }
    }
    private func loadData(){
        
    }
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                NavigationBarViewII(title: "watchmymind", imageIconRight: "plus")
                    
                    .padding(.horizontal , 15)
                    .padding(.bottom)
                    .padding(.top ,
                             UIApplication.shared.windows.first?.safeAreaInsets.top)
                
              
                ScrollView(.vertical, showsIndicators: true){
                    
                    HStack {
                        Image(systemName: "hourglass.bottomhalf.fill")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Text("You might close this app to get a new snapshot data")
                            
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    if !isActivity {
                    ForEach(self.mindfulnessMV.mindfulnessArr){ data in
                        BioDataCardIView(title: "breathing", imageIcon: "lungs", value: "\(data.time)", date: data.date)
                        
                    }//: LOOP
                    }else{
                        
                                ForEach(self.autoActivityStore.autoActivityCollection){ data in
                                    
                                    NavigationLink(
                                        destination: MoreBioDataView(sample: data.workOut, hrv: data.avgHeartRate),
                                        label: {
                                            BioDataCardIView(title: data.workOut.workoutActivityType.name, imageIcon: data.workOut.workoutActivityType.associatedIcon!, value: "\(Int(data.avgHeartRate)) BMP", date:data.workOut.startDate)
                                        })
                                   
                                     
                           
                                }
                    }
                        
                }//: SCROLL VIEW
                    
                
               
 
                
                .ignoresSafeArea(.all , edges: .bottom)
                Spacer()
            }//: VSTACK
           
            .ignoresSafeArea(.all , edges: .bottom)
                
        }//: ZSTACK
        .ignoresSafeArea(.all , edges : .top)
       
        .fullScreenCover(isPresented: $isPresented, content: {
            LoadingView(showModal: self.$isPresented, isActivity: self.isActivity,  count: self.isActivity ? self.mindfulnessMV.mindfulnessArr.count : self.autoActivityStore.autoActivityCollection.count , activityPath: self.autoActivity.activityPath, decription: "please use your Apple Watch to complete an activity by use The Breathe app").environment(\.managedObjectContext, viewContext)
        })
        .onAppear(perform: {
            fetchData()
            self.autoActivityStore.loadData(startDate: Date(), numberOfObserved: -30)
          
            
        })
        .onChange(of: isPresented, perform: { value in
           fetchData()
           self.autoActivityStore.loadData(startDate: Date(), numberOfObserved: -30)
            self.avtivityStorage.activityCount(path: self.autoActivity.activityPath){ success , numberOfCollection in
                
                if !isActivity{
                    // mindfull
                    print("number of collection ==> \(numberOfCollection)")
                    print("mindfulness count ==> \(self.mindfulnessMV.mindfulnessArr.count)")
                    
                    if numberOfCollection < self.mindfulnessMV.mindfulnessArr.count{
                        let newData = self.mindfulnessMV.getData()
                        
                        self.avtivityStorage.setResults(path: self.autoActivity.activityPath, results: newData) { status, msgg in
                            if status{
                                
                            }else{
                                
                            }
                            
                        }
                        
                     
                        
                    }
                    
                }else{
                    //execrise
                    if numberOfCollection < self.autoActivityStore.autoActivityCollection.count{
                        let newData = self.autoActivityStore.getData()
                        
                        self.avtivityStorage.setResults(path: self.autoActivity.activityPath, results: newData) { status, msgg in
                            if status{
                                
                            }else{
                                
                            }
                        }
                    }
                    
                }
                
            }
        })
        
       
       
    }
}
// MARK: -PREVIEW
struct BioDataListView_Previews: PreviewProvider {
    static var previews: some View {
        BioDataListView(headline: "BREATHING", isActivity: true, autoActivity: AutoActivitiesModel(createdby: "", description: "", imageIcon: "", title: "", type: "", progress: 2, everyDay: false, time: 20, round: 1, NoOfDate: 5, activityPath: "", observedPath: "",startDate: Date(),endDate:Date()))
            
    }
}
