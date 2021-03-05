//
//  MindfulnessStore.swift
//  WatchMyMind
//
//  Created by Suriya on 1/3/2564 BE.
//

import Foundation
class MindfulnessStore : ObservableObject {
    @Published var mindfulnessArr :[MindfulnessModel] = [MindfulnessModel]()
    
    init(MindfulnessArr : [MindfulnessModel]) {
        self.mindfulnessArr = MindfulnessArr
    }
    var totoTime : Int32{
        var toto : Int32 = 0
        for mf in mindfulnessArr {
            toto += mf.time
        }
        return toto
    }
    func setMindfulness(newData : [MindfulnessModel]){
        mindfulnessArr.removeAll()
        mindfulnessArr = newData
    }
    
  
    
}
