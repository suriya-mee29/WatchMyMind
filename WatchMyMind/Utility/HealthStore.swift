//
//  HealthStore.swift
//  WatchMyMind
//
//  Created by Suriya on 24/2/2564 BE.
//

import Foundation
import HealthKit
class HealthStore {
    var healthStore : HKHealthStore?
    var query : HKStatisticsCollectionQuery?
    var querySampleQuery : HKSampleQuery?
    
    init(){
        // to check data is avaliable or not?
        if HKHealthStore.isHealthDataAvailable(){
            //Create instance of HKHealthStore
            healthStore = HKHealthStore()
        }
        
    }
    // Authorization
    func requestAuthorization(compleion: @escaping(Bool)-> Void){
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        let mindfulSampleType = HKSampleType.categoryType(forIdentifier: .mindfulSession)!
        
        guard let healthStore = self.healthStore else { return compleion(false)}
        
        healthStore.requestAuthorization(toShare: [], read: [stepType,mindfulSampleType]) { (success, error) in
            compleion(success)
        }
    }
    //Calculate steps count
    func calculateSteps(completion : @escaping(HKStatisticsCollection?)->Void){
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        let startDate  = Calendar.current.date(byAdding: .day,value: -7, to: Date())
        let anchorDate = Date.mondayAt12AM()
        let daily = DateComponents(day:1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date()
                                                    , options: .strictStartDate)
        //cumulativeSum  (Watch+Iphone)
       query =  HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        query!.initialResultsHandler = { query, statisticsCollection , error in
            completion(statisticsCollection)
        }
        
        if let healthStore = self.healthStore, let query = self.query {
            healthStore.execute(query)
        }
    }
    
    // DailyMindfulnessTime
    func getDailyMindfulnessTime(completion: @escaping (TimeInterval) -> Void) {

                let sampleType = HKSampleType.categoryType(forIdentifier: .mindfulSession)!
                let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
                let startDate = Calendar.current.startOfDay(for: Date())
                let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)
                let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

                 querySampleQuery = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { (_, results, error) in
                    
                    if error != nil {
                        print(" HealthKit returned error while trying to query today's mindful sessions. The error was: \(String(describing: error?.localizedDescription))")
                    }
                    
                    if let results = results {
                        var totalTime = TimeInterval()
                        for result in results {
                            totalTime += result.endDate.timeIntervalSince(result.startDate)
                        }
                        completion(totalTime)
                    } else {
                        completion(0)
                    }
                }
        
        
            if let healthStore = self.healthStore, let querySampleQuery  = self.querySampleQuery {
            healthStore.execute(querySampleQuery)
                }

            }

    }

extension Date {
    static func mondayAt12AM() -> Date{
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear,.weekOfYear],from: Date()))!
    }
    
}
