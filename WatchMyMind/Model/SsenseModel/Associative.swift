//
//  Associative.swift
//  WatchMyMind
//
//  Created by Suriya on 1/5/2564 BE.
//

import Foundation
class Associative : Codable {
    ///ข้อความที่แสดงการเปรียบเทียบ
    let text : String
    ///แบรนด์ที่ถูกวิเคราะห์ว่าเป็นเชิงบวก
    let ent_pos : [String]
    ///แบรนด์ที่ถูกวิเคราะห์ว่าเป็นเชิงลบ
    let ent_neg : [String]
    ///เป็นข้อความเชิงบวกใช่หรือไม่ (true=ใช่, false =ไม่ใช่)
    let polarity_pos : Bool
    ///เป็นข้อความเชิงบวกใช่หรือไม่ (true=ใช่, false =ไม่ใช่)
    let polarity_neg : Bool
    ///ตําแหน่งอักขระแรกของข้อความที่แสดงการเปรียบเทียบ
    let beginIndex : Int
    ///ตําแหน่งอักขระสุดท้ายของข้อความที่แสดงการเปรียบเทียบ
    let endIndex : Int
    ///array ของคําคุณลักษณะ (feature word)
    let asp : [String]
    
    
    enum CodingKeys: String, CodingKey {
            case text = "text"
            case ent_pos = "ent-pos"
            case ent_neg = "ent-neg"
            case polarity_pos = "polarity-pos"
            case polarity_neg = "polarity-neg"
            case beginIndex = "beginIndex"
            case endIndex = "endIndex"
            case asp = "asp"
        }
    
    
    
    init (text: String = "" , ent_pos :[String] = [] , ent_neg : [String] = [] , polarity_pos : Bool = false ,polarity_neg : Bool  = false, beginIndex : Int = 0 , endIndex : Int  = 0, asp : [String] = []){
        
        self.text = text
        self.ent_pos = ent_pos
        self.ent_neg = ent_neg
        self.polarity_pos = polarity_pos
        self.polarity_neg = polarity_neg
        self.beginIndex = beginIndex
        self.endIndex = endIndex
        self.asp = asp
    }
    
    
}
