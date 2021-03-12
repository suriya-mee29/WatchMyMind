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
    var summaryQuery : HKActivitySummaryQuery?
    var mindfulObserverQuery : HKObserverQuery?
    
    var totalTime = TimeInterval()
    
    let mindfulType = HKSampleType.categoryType(forIdentifier: .mindfulSession)!
    let standType = HKQuantityType.quantityType(forIdentifier: .appleStandTime)!
    let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
    let activityType = HKObjectType.activitySummaryType()
    
    
    init(){
        // to check data is avaliable or not?
        if HKHealthStore.isHealthDataAvailable(){
            //Create instance of HKHealthStore
            healthStore = HKHealthStore()
            
        }
        
    }
    // MARK: - Authorization
    func requestAuthorization(compleion: @escaping(Bool)-> Void){
       
        
        guard let healthStore = self.healthStore else { return compleion(false)}
        
        healthStore.requestAuthorization(toShare: [], read: [mindfulType,standType,stepType,sleepType,activityType]) { (success, error) in
            compleion(success)
        }
    }
    // MARK: - Calculate Sleeping
    func getDailySleeping(){
        
    }
    // MARK: - Calculate Moving
    func getDailyMoving (completion : @escaping(HKActivitySummary?)->Void){
        let calendar = Calendar.autoupdatingCurrent
        var dateComponents = calendar.dateComponents(
            [ .year, .month, .day ],
            from: Date())
        
        // This line is required to make the whole thing work
          dateComponents.calendar = calendar
        let predicate = HKQuery.predicateForActivitySummary(with: dateComponents)
        summaryQuery = HKActivitySummaryQuery(predicate: predicate) { (query, summaries, error) in
            guard let summaries = summaries else {
               // print("return \(String(describing: error?.localizedDescription))")
                // No data returned. Perhaps check for error
                return
            }
            if summaries.count != 0{
            completion(summaries[0])
            }
            // Handle the activity rings data here
            
        }
        
        if let healthStore = self.healthStore , let query = self.summaryQuery {
          
             healthStore.execute(query)
                
           
        }
        
        
    }
    // MARK: - Calculate hr. of standing
    func calculateStanding(completion : @escaping(HKStatisticsCollection?)->Void){
        let calendar = Calendar.autoupdatingCurrent
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour], from: Date())
        let endDate = Date()
        let startDate = calendar.date(from: dateComponents)!
        var interval = DateComponents()
        interval.hour = 1
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: self.standType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: startDate, intervalComponents: interval)
        
        query!.initialResultsHandler = { query, statisticsCollection , error in
            completion(statisticsCollection)
        }
        if let healthStore = self.healthStore, let query = self.query {
            healthStore.execute(query)
        }
    }
    
    func getDailyStanding(completion: @escaping (TimeInterval) -> Void){
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        querySampleQuery = HKSampleQuery(sampleType: stepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { (_, results, error) in
            
            if let results = results {
                var totalTime = TimeInterval()
                for result in results{
                    totalTime += result.endDate.timeIntervalSince(result.startDate)
                }
                completion(totalTime)
            }else{
                completion(0)
                
            }
            
        }
        
        if let healthStore = self.healthStore , let querySampleQuery = self.querySampleQuery {
          
            healthStore.execute(querySampleQuery)
        
        }
        
    }
    
    
    // MARK: - Calculate steps count
    func calculateSteps(completion : @escaping(HKStatisticsCollection?)->Void){
       
        
        let startDate  = Calendar.current.date(byAdding: .day,value: -7, to: Date())
        let anchorDate = Date.mondayAt12AM()
        let daily = DateComponents(day:1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date() , options: .strictStartDate)
        //cumulativeSum  (Watch+Iphone)
        query =  HKStatisticsCollectionQuery(quantityType: self.stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        query!.initialResultsHandler = { query, statisticsCollection , error in
            completion(statisticsCollection)
          
        }
        
        if let healthStore = self.healthStore, let query = self.query {
            healthStore.execute(query)
        }
    }
    
    
    // MARK: - MINDFULNESS V1
    // DailyMindfulnessTime
    func getDailyMindfulnessTime(completion: @escaping (TimeInterval) -> Void) {

               
                let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
                let startDate = Calendar.current.startOfDay(for: Date())
                let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)
                let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

                 querySampleQuery = HKSampleQuery(sampleType: mindfulType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { (_, results, error) in
                    
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
    
    // MARK: - MINDFULNESS
    func mindfulObserverQueryTriggered() {
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        let mindfulSampleQuery = HKSampleQuery(
                sampleType: mindfulType,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors:  [sortDescriptor],
                resultsHandler: { [weak self] (query, samples, error) in
                    if error != nil {
                    print(" HealthKit returned error while trying to query today's mindful sessions. The error was: \(String(describing: error?.localizedDescription))")
                    }
                    self?.mindfulSampleQueryFinished(samples: samples ?? [])
            })
        if let healthStore = self.healthStore {
            healthStore.execute(mindfulSampleQuery)
        }
    } // END OF MINDFULOBSERVER QUERY TRIGGRED
    
    func startObservedMindful(){
        
      mindfulObserverQuery = HKObserverQuery( sampleType: mindfulType , predicate: nil) {
        [weak self] (query, completion, error) in
            self?.mindfulObserverQueryTriggered()
        }
        
        if let healthStore = self.healthStore , let mindfulObserverQuery = self.mindfulObserverQuery {
            healthStore.execute(mindfulObserverQuery)
        }
        
    }// END OF SRATR OBSERVED MINDFULNESS
    
    func mindfulSampleQueryFinished(samples: [HKSample]){
        if samples.count > 0 {
        var ttTime = TimeInterval()
        for sample in samples {
            ttTime += sample.endDate.timeIntervalSince(sample.startDate)
        }
            print("(count > 0 )total time --> \(ttTime)")
        }else{
            print("total time --> 0")
        }
       
  }
    func testAnchoredQuery(){
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        var anchor = HKQueryAnchor.init(fromValue: 0)
        let query = HKAnchoredObjectQuery(type: mindfulType,
                                              predicate: predicate,
                                              anchor: anchor,
            limit: HKObjectQueryNoLimit) { (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in
                    guard let samples = samplesOrNil, let deletedObjects = deletedObjectsOrNil else {
                        fatalError("*** An error occurred during the initial query: \(errorOrNil!.localizedDescription) ***")
                    }
                    anchor = newAnchor!
            self.mindfulSampleQueryFinished(samples: samples)
            print(anchor.description)
            }
        
        query.updateHandler = { (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in
        
               guard let samples = samplesOrNil, let deletedObjects = deletedObjectsOrNil else {
                   // Handle the error here.
                   fatalError("*** An error occurred during an update: \(errorOrNil!.localizedDescription) ***")
               }
        
               anchor = newAnchor!
              print("update")
            self.mindfulSampleQueryFinished(samples: samples)
            
            print(anchor.description)
            
        
        
               
        
              
           }
        self.healthStore?.execute(query)
    }
    
    
    } //: End of Class



extension Date {
    static func mondayAt12AM() -> Date{
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear,.weekOfYear],from: Date()))!
    }
    
}
