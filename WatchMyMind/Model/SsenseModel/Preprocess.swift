//
//  Preprocess.swift
//  WatchMyMind
//
//  Created by Suriya on 1/5/2564 BE.
//

import Foundation
class Preprocess : Codable {
    ///ข้อความที่นําเข้าไปวิเคราะห์
    let input : String
    ///คำที่แสดงเชิงลบ
    let neg : [String]
    ///คำที่แสดงเชิงบวก
    let pos : [String]
    ///array ของคําสําคัญ
    let keyword : [String]
    ///array ของคําที่ได้จากการตัดคํา input
    let segmented : [String]
    
    enum CodingKeys: String, CodingKey {
            case input = "input"
            case neg = "neg"
            case pos = "pos"
            case keyword = "keyword"
            case segmented = "segmented"
        
           
        }
    init (input : String = "" , neg : [String] = [] , pos : [String] = [] , keyword : [String] = [], segmented :[String] = []){
        self.input = input
        self.neg = neg
        self.pos = pos
        self.keyword = keyword
        self.segmented = segmented
    }
}
