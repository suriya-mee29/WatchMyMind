//
//  Constant.swift
//  WatchMyMind
//
//  Created by Suriya on 2/2/2564 BE.
//

import SwiftUI

//LAYOUT
let columnSpacing : CGFloat = 40
let rowSpacing : CGFloat = 500
var gridLayout : [GridItem] {
    return Array(repeating: GridItem(.flexible(),spacing: rowSpacing), count: 1)
}
//data

let manualActivity = [["name": "music relaxation","progrss": "50"],
                      ["name": "reading","progrss": "65"],
                      ["name": "hobbies","progrss": "20"],
                      ["name": "scaring videos","progrss": "10"]]

let ac : [Activity] = Bundle.main.decode("Activities.json")
let ac2 : [Activity] = Bundle.main.decode("Activities2.json")




let autoActivity = [["name": "Workout(swwiming)","progrss": "80"]
                    ,["name": "mindnessful","progrss": "10"]]

let taskDateFormat: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateStyle = .long
       return formatter
   }()
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(secondsFromGMT: 7)
    formatter.dateFormat = "HH:mm"
    return formatter
}()



enum NavigationTag : Int {
    case TO_BIODATA_VIEW = 1
}

