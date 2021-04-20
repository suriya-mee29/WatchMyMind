//
//  UserModel.swift
//  WatchMyMind
//
//  Created by Suriya on 22/3/2564 BE.
//

import Foundation
struct UserModel :  Codable{
    let timestamp : TimeInterval
    var status : Bool
    let message : String
    let data : DataUserModel
}
