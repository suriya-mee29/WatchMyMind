//
//  ActivityMV.swift
//  WatchMyMind
//
//  Created by Suriya on 23/2/2564 BE.
//

import Foundation
class ActivityViewModel: ObservableObject {
    @Published var activitys : [Activity]
    
    init(){
        self.activitys = Bundle.main.decode("Activities.json")
    }
    
    
    func setProgass(progass  :String) {
        activitys[0].setProgress(pro: progass)
    }
         
}
