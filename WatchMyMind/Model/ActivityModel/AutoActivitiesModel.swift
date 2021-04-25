//
//  AutoActivityModel.swift
//  WatchMyMind
//
//  Created by Suriya on 20/4/2564 BE.
//

import Foundation

struct AutoActivitiesModel : Codable, Identifiable{
    let id : UUID
    let createdby : String
    let description : String
    let imageIcon : String
    let title : String
    let type : String
    var progress : Int
    
    //fequency
    let everyDay : Bool
    let time : Int
    let round : Int
    let NoOfDate : Int
    
    init(id: UUID = UUID() , createdby: String , description: String , imageIcon : String , title : String ,type : String , progress: Int , everyDay : Bool , time : Int , round : Int , NoOfDate : Int) {
        self.id = id
        self.createdby = createdby
        self.description = description
        self.imageIcon = imageIcon
        self.title = title
        self.type = type
        self.progress = progress
        
        self.everyDay = everyDay
        self.time = time
        self.NoOfDate = NoOfDate
        self.round = round
    }
    
}
