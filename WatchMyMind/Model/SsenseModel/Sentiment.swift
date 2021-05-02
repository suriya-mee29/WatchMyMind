//
//  Sentiment.swift
//  WatchMyMind
//
//  Created by Suriya on 1/5/2564 BE.
//

import Foundation
class Sentiment : Codable {
    /// ขั้วอารมณ์ความคิดเห็น (positive: เชิงบวก, negative: เชิงลบ, ค่าว่าง: ไม่เป็นทั้งบวกและลบ)
    let polarity : String
    ///ร้อยละคะแนนความมั่นใจ (confidence)
    let score : String
    ///มีข้อความเชิงบวกใช่หรือไม่ (true=ใช่, false =ไม่ใช่)
    let polarity_pos : Bool
    ///มีข้อความเชิงบวกใช่หรือไม่ (true=ใช่, false =ไม่ใช่)
    let polarity_neg : Bool
    
    enum CodingKeys: String, CodingKey {
            case polarity = "polarity"
            case score = "score"
            case polarity_pos = "polarity-pos"
            case polarity_neg = "polarity-neg"
        
           
        }
    init(polarity : String = "" , score : String  = "" , polarity_pos : Bool  = false , polarity_neg : Bool = false) {
        self.polarity = polarity
        self.score = score
        self.polarity_pos = polarity_pos
        self.polarity_neg = polarity_neg
    }

}
