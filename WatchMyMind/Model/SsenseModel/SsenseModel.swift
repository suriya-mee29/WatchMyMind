//
//  SsenseModel.swift
//  WatchMyMind
//
//  Created by Suriya on 1/5/2564 BE.
//

import Foundation
struct SsenseModel : Codable{
    ///ผลวิเคราะห์ความคิดเห็นว่าเป็นเชิงบวกหรือลบ
    let sentiment : Sentiment
    ///ผลวิเคราะห์จุดประสงค์ของข้อความ
    let intention : Intention
    ///ผลลัพธ์การจัดการข้อความก่อนวิเคราะห์
    let preprocess : Preprocess
    ///array ของข้อความที่แสดงการแจ้งเตือน
    let alert : [String]
    ///ผลวิเคราะห์ข้อความที่มีการเปรียบเทียบแบรนด์/สินค้า
    let comparative : [Comparative]
    ///ผลวิเคราะห์ข้อความที่มีความคิดเห็นต่อแบรนด์/สินค้า
    let associative : [Associative]
    
    
}
