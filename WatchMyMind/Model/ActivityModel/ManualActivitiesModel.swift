//
//  ManualActivitiesModel.swift
//  WatchMyMind
//
//  Created by Suriya on 20/4/2564 BE.
//

import Foundation
import SwiftUI
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
    let observedPath : String
    
    //date
    let startDate : Date
    let endDate : Date
    
    
    var todo : Int {
        var inRound = round
        if inRound < 0 {
            inRound = 1
        }
        if everyDay {
            // fund number of date
            
            let numberofdays = self.daysBetween(start: startDate, end: endDate)
            print("number of days \(numberofdays)")
           
            return numberofdays * inRound
        }else{
            var inNumber = NoOfDate
            if inNumber < 0{
                inNumber = 1
            }
            return inNumber * inRound
        }
    }
    
  
    
    
    init( id: UUID = UUID() , createdby : String , description : String ,imageIcon : String , title : String ,type : String ,link : String = "" , photoURL : String = "" ,indicator : [String] = [] , progress : Int = 0, everyDay : Bool , time : Int , round : Int , NoOfDate : Int = -1 , outcomeReq :[String] = [] ,activityPath : String, observedPath: String , startDate : Date , endDate : Date) {
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
        self.observedPath = observedPath
        
        self.startDate = startDate
        self.endDate = endDate
    }
   private func daysBetween(start: Date, end: Date) -> Int {
        let start = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: start)!
        let end = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: end)!
        return Calendar.current.dateComponents([.day], from: start, to: end).day ?? 0
    }
    
}
