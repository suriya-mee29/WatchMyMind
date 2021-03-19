//
//  AutoActivityStore.swift
//  WatchMyMind
//
//  Created by Suriya on 19/3/2564 BE.
//

import Foundation
import HealthKit

class AutoActivityStore : ObservableObject {
    @Published var autoActivityCollection : [AutoActivityModel]
    var healthStore = HealthStore()
    let heartRateUnit:HKUnit = HKUnit(from: "count/min")
    
    init(autoActivityCollection: [AutoActivityModel]) {
        self.autoActivityCollection = autoActivityCollection
    }
    
    func setAutoActivityCollection(newAutoActivityCollection: [AutoActivityModel]){
        self.autoActivityCollection = newAutoActivityCollection
    }
    
    func appendNewData(autoActivityModel : AutoActivityModel){
        print("append")
        self.autoActivityCollection.append(autoActivityModel)
    }
    func displayData (){
        print("display")
        print(self.autoActivityCollection.count)
        for at in self.autoActivityCollection {
            print("\(at.workOut.workoutActivityType.name)")
            print("start: \(at.workOut.startDate) - end: \(at.workOut.endDate)")
            print("avg hr \(at.avgHeartRate)")
            for hr in at.heartRate{
                print("\(hr) BMP")
            }
            print("------------------------------------")
        }
        
    }
    func loadData (startDate : Date , numberOfObserved : Int){
        var heartRateArr : [Double] = []
        var AVGheartRate : Double = -1.0
        self.healthStore.requestAuthorization{ seccess in
            if seccess {
                self.healthStore.calculateWorkout2(startDate: startDate, numberOfObserved: numberOfObserved) { (workout) in
                    if let workout = workout{
                        self.setAutoActivityCollection(newAutoActivityCollection: [])
                        for wk in workout {
                            
                           
                            // guery - (1) Double callection of Heart rate
                            self.healthStore.getHeartRateBetween2(startDate: wk.startDate, endDate: wk.endDate) { (results) in
                                guard let results = results else {
                                    print("error from get Double callection of Heart rate")
                                    return
                                }
                                for (_,result) in results.enumerated(){
                                    guard let currData:HKQuantitySample = result as? HKQuantitySample else {
                                        print("error from converst HKQuantitySample (currData)")
                                        return }
                                    //1.2 append to Double collection
                                    heartRateArr.append(currData.quantity.doubleValue(for: self.heartRateUnit))
                                   
                                    
                                }
                                // query - (2) heart rate statistic sample
                                self.healthStore.getAVGHeartRate(startDate: wk.startDate, endDate: wk.endDate) { (statistic) in
                                    if let quantity = statistic?.averageQuantity(){
                                        
                                        let beats: Double? = quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
                                        AVGheartRate = beats ?? -1.0
                                       
                                        
                                        
                                    }
                                   
                                    self.appendNewData(autoActivityModel: AutoActivityModel(id: wk.uuid, workOut: wk, heartRate: heartRateArr, avgHeartRate: AVGheartRate))
                                  //  print(self.autoActivityCollection.count)
                                   // self.displayData()
                                }//EO - getAVGHeartRate
                            } //EO - getHeartRateBetween2
                           
                            
                            
                        }// EO - Loop Workouts
                     
                    }
                
                }// EO - Calculate Workout-V2
                
            }
        }
        
    }
}
