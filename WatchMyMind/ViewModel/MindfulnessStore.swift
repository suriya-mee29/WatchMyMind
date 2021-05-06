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
    func getData ()-> [[String:Any]]{
        var newData = [[String:Any]]()
        
        if self.mindfulnessArr.count != 0 {
        for i in 0...(self.mindfulnessArr.count - 1){
            let date = self.mindfulnessArr[i].date
            let time = Int(self.mindfulnessArr[i].time)
            
            newData.append(["date":date , "time":time])
        }
            return newData
        }else{
            return[]
        }
      
    }
    
  
    
}
