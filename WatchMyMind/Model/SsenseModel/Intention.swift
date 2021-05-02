//
//  Intention.swift
//  WatchMyMind
//
//  Created by Suriya on 1/5/2564 BE.
//

import Foundation

class Intention : Codable {
    
    ///ร้อยละคะแนนความมั่นใจ (confidence)ว่าเป็นข้อความแสดงความคิดเห็น
    let sentiment : String
    ///ร้อยละคะแนนความมั่นใจ (confidence) ว่าเป็นข้อความประกาศหรือโฆษณา
    let announcement : String
    ///ร้อยละคะแนนความมั่นใจ (confidence) ว่าเป็นข้อความในเชิงร้องขอ
    let request : String
    ///ร้อยละคะแนนความมั่นใจ (confidence) ว่าเป็นข้อความในเชิงคําถาม
    let question : String
    
    enum CodingKeys: String, CodingKey {
            case sentiment = "sentiment"
            case announcement = "announcement"
            case request = "request"
            case question = "question"
        
           
        }
    
    init(sentiment : String  = "", announcement : String = "" , request : String  = "", question : String = "" ){
        self.sentiment = sentiment
        self.announcement = announcement
        self.request = request
        self.question = question
    }
}
