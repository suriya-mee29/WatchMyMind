//
//  AutoActivityModel.swift
//  WatchMyMind
//
//  Created by Suriya on 19/3/2564 BE.
//

import Foundation
import HealthKit
struct AutoActivityModel : Identifiable {
    let id : UUID
    let workOut : HKWorkout
    let heartRate : [Double]
    let avgHeartRate : Double
    
}
