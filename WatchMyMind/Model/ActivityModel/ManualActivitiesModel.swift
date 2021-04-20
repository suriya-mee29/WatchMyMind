//
//  ManualActivitiesModel.swift
//  WatchMyMind
//
//  Created by Suriya on 20/4/2564 BE.
//

import Foundation
struct ManualActivitiesModel : Codable {
    let createdby : String
    let description : String
    let imageIcon : String
    let title : String
    let type : String
    // optional
    let link : String
    let picture : Data
    
    init( createdby : String , description : String ,imageIcon : String , title : String ,type : String ,link : String = "" , picture : Data = Data()){
        self.createdby = createdby
        self.description = description
        self.imageIcon = imageIcon
        self.title = title
        self.type = type
        self.link = link
        self.picture = picture
    }
    
}
