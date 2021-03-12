//
//  LoadingView.swift
//  WatchMyMind
//
//  Created by Suriya on 26/2/2564 BE.
//

import SwiftUI
import HealthKit

struct LoadingView: View {
    // MARK: - PROPERTIES
     var healthStore : HealthStore? = HealthStore()
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var num : Int = 0
    
    @Binding var showModal: Bool
   
    var decription : String
    
    // MARK: - FUNCTION
    private func updateUIFromStatistics(_ StatisticsCollection : HKStatisticsCollection){
        
        
    }
    // MARK: - BODY
    var body: some View {
        
        VStack (alignment: .center){
            Spacer()
           WatchView()
            Spacer()
          
                Text(decription)
                   
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding(.horizontal,30)
                   
            Button(action: {
                
                if let healthStore = healthStore {
                    healthStore.requestAuthorization { success in
                        print("btn")
                       // healthStore.testAnchoredQuery()
                       // healthStore.getDailyMindfulnessTime2()
                        //healthStore.startObservedMindful()
                       /* healthStore.getDailyStanding { time in
                            print(time.stringFromTimeInterval())
                        }*/
                        
                        healthStore.getDailyMoving { summary in
                            //let energyUnit = HKUnit.kilocalorie()
                            print("dd")
                            let value = summary?.activeEnergyBurned.doubleValue(for: HKUnit.kilocalorie())
                            print(Double(value ?? 0 ))
                        }
                    }
                }
            }, label: {
                Text("Button")
            })
            Spacer()
            
            
        }
        .navigationBarBackButtonHidden(true)
        .onReceive(timer) { _ in
           
            
            if let healthStore = healthStore {
                healthStore.requestAuthorization { success in
                    if success {
                       // healthStore.getDailyMindfulnessTime2()
                       /* healthStore.getDailyMindfulnessTime { time in
                            print("\(time)")
                            
                            if !time.isEqual(to: 0.0){
                                
                                //(1) Craete new record in coredata
                                let newMindfulness = Mindfulness(context: viewContext)
                                newMindfulness.id = UUID()
                                newMindfulness.time = Int32(time)
                                newMindfulness.date = Date()
                                
                                //(2) save CoreData
                                do {
                                    try viewContext.save()
                                }catch{
                                    let error = error as NSError
                                    fatalError("Unresolved Error: \(error)")
                                }

                                //(3) Stop Timer
                                print("Stop timer")
                                self.timer.upstream.connect().cancel()
                               
                                //(4) dismiss
                                self.showModal = false
                                print(showModal)
                            }
                            
                        }*/
                       
                           
                    } //: SUCCESS
                     
                }
            }
            
        }// ON RECEIVE
        .onDisappear(perform: {
            self.timer.upstream.connect().cancel()
        })//ON DISAPPEAR
        .onAppear(perform: {
            self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        })
    }
}
// MARK: - PROPERTIES
struct LoadingView_Previews: PreviewProvider {
    @State static var showModal = true
    static var previews: some View {
        LoadingView(showModal: $showModal, decription: "Please use your Apple Watch to complete an activity by use The Breathe app")
            .preferredColorScheme(.dark)
    }
}
