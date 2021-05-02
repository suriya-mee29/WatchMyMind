//
//  ManualActivitiesModel.swift
//  WatchMyMind
//
//  Created by Suriya on 20/4/2564 BE.
//

import Foundation
struct ManualActivitiesModel :  Identifiable{
    let id : UUID
    let createdby : String
    let description : String
    let imageIcon : String
    let title : String
    let type : String
    var progress : Int
    // optional
    let link : String
    let photoURL : String
    
    //indicator
    let indicator : [String]
    
    //fequency
    let everyDay : Bool
    let time : Int
    let round : Int
    let NoOfDate : Int
    
    //outcome req
    let outcomeReq :[String]
    
    let activityPath : String
    
  
    
    
    init( id: UUID = UUID() , createdby : String , description : String ,imageIcon : String , title : String ,type : String ,link : String = "" , photoURL : String = "" ,indicator : [String] = [] , progress : Int = 0, everyDay : Bool , time : Int , round : Int , NoOfDate : Int = -1 , outcomeReq :[String] = [] ,activityPath : String) {
        self.id = id
        self.createdby = createdby
        self.description = description
        self.imageIcon = imageIcon
        self.title = title
        self.type = type
        self.link = link
        self.photoURL = photoURL
        self.indicator = indicator
        self.progress = progress
        
        self.everyDay = everyDay
        self.time = time
        self.round = round
        self.NoOfDate = NoOfDate
        
        self.outcomeReq = outcomeReq
        self.activityPath = activityPath
        
    }
  
    
}
