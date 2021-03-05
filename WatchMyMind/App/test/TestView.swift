//
//  TestView.swift
//  WatchMyMind
//
//  Created by Suriya on 24/2/2564 BE.
//

import SwiftUI
import CombineSchedulers


struct TestView: View {
    private var healthStore : HealthStore?
    @State private var data : String = "0"
    init() {
        healthStore = HealthStore()
    }
    func test(){
        
        
    
    }
    
    var body: some View {
        VStack {
            Text(data)
               
        }
        .onAppear(perform: {
            if let healthStore = healthStore {
                healthStore.requestAuthorization { success in
                    if success {
                        healthStore.getDailyMindfulnessTime { time in
                            data = "\(time.isEqual(to: 0.0))"
                        }
                       
                           
                    } //: SUCCESS
                     
                }
            }
            
    }) // onApprar
        
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
