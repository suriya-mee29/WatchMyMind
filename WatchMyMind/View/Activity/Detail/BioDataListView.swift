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
    @State var mindfulnessArr = [MindfulnessModel]()
    @ObservedObject var mindfulnessMV : MindfulnessStore
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    var MindfulnessCollection : FetchedResults<Mindfulness>
    @State private var isPresented = true
    @State private var hasdone : Int = 0
    
    var healthStore = HealthStore()
    // MARK: - CONSTRUCTOR
    init(headline: String) {
        self.headLine = headline
        mindfulnessMV = MindfulnessStore(MindfulnessArr: [])
       
    }
   
    // MARK: - FUNCTION
    private func fetchData(){
        
        var arrMindFul = [MindfulnessModel]()
        healthStore.mindfultime(startDate: Date() , numberOfday: -7) { (samples) in
            for sample in samples {
                print("\(dateFormatter.string(from: sample!.startDate))")
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
        var arr = [MindfulnessModel]()
        if MindfulnessCollection.count != 0 {
            MindfulnessCollection.forEach { mf in
                guard let id = mf.id else {return}
                guard let date = mf.date else {return}
                let time = mf.time
                arr.append(MindfulnessModel(id: id, date: date, time: time))
            }//: LOOP
            self.mindfulnessMV.setMindfulness(newData: arr)
        }else{
           //base case
            print("base case --> one")
        }
       
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
                    ForEach(self.mindfulnessMV.mindfulnessArr){ data in
                        BioDataCardIView(title: "breathing", breating: "\(data.time)", date: data.date)
                        
                    }//: LOOP
                        
                }//: SCROLL VIEW
                    
                
               
 
                
                .ignoresSafeArea(.all , edges: .bottom)
                Spacer()
            }//: VSTACK
           
            .ignoresSafeArea(.all , edges: .bottom)
                
        }//: ZSTACK
        .ignoresSafeArea(.all , edges : .top)
       
        .fullScreenCover(isPresented: $isPresented, content: {
            LoadingView(showModal: self.$isPresented, decription: "please use your Apple Watch to complete an activity by use The Breathe app").environment(\.managedObjectContext, viewContext)
        })
        .onAppear(perform: {
            print("OnAppear in loadData")
            fetchData()
          
            
        })
        .onChange(of: isPresented, perform: { value in
            print("chang")
           fetchData()
        })
        
       
       
    }
}
// MARK: -PREVIEW
struct BioDataListView_Previews: PreviewProvider {
    static var previews: some View {
        BioDataListView(headline: "BREATHING")
            
    }
}
