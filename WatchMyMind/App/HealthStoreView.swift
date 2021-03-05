//
//  HealthStoreViewView.swift
//  WatchMyMind
//
//  Created by Suriya on 24/2/2564 BE.
//

import SwiftUI
import HealthKit

struct HealthStoreView: View {
    private var healthStore : HealthStore?
    @State private var staps : [Steps] = [Steps]()
    @State private var time : String = "gggg"
    init() {
        healthStore = HealthStore()
    }
    private func updateUIFromStatictics(_ statisticsCollection: HKStatisticsCollection){
        let startDate  = Calendar.current.date(byAdding: .day,value: -6, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics , stop) in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            let step = Steps(count: Int(count ?? 0) ,date : statistics.startDate)
            staps.append(step)
            
            
        }
        
    }
    var body: some View {
        VStack {
            Text(time)
            List(staps,id: \.id){ step in
                VStack {
                    Text("\(step.count)")
                    Text(step.date,style: .date).opacity(0.5)
                                    }
            }
                .onAppear(perform: {
                    if let healthStore = healthStore {
                        healthStore.requestAuthorization { success in
                            if success{
                                healthStore.calculateSteps { statisticsCollection in
                                    if let statisticsCollection = statisticsCollection {
                                        // update ui
                                        updateUIFromStatictics(statisticsCollection)
                                    }
                                    
                                }
                               
                                   
                            } //: SUCCESS
                             
                        }
                    }
                    
            }) // onApprar
            
        }
    }
}

struct HealthStoreViewView_Previews: PreviewProvider {
    static var previews: some View {
        HealthStoreView()
    }
}
