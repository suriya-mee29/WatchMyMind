//
//  utity.swift
//  WatchMyMind
//
//  Created by Suriya on 5/4/2564 BE.
//

import Foundation

enum USER_STATUS : String ,CodingKey{
    case ACTIVE = "active"
    case INACTIVE = "inactive"
    case ACTIVE_WARNING = "warning"
    case DISCONTINUE = "discontinue"
    
}
enum INDICATOR : String {
    case SCALING = "scaling"
    case NOTING = "noting"
    case HEART_RATE = "heart rate"
}
