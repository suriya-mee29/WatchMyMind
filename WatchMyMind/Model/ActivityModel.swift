//
//  ActivityModel.swift
//  WatchMyMind
//
//  Created by Suriya on 23/2/2564 BE.
//

import Foundation

struct Activity : Identifiable , Codable{
    let id : String
    let title : String
    let description : String
    let type : String
    let imageIcon : String
    var progrss: String
    
    mutating func setProgress(pro: String){
        self.progrss = pro
    }
    

}



