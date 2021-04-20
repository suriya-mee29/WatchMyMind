//
//  Constant.swift
//  WatchMyMind
//
//  Created by Suriya on 2/2/2564 BE.
//

import SwiftUI

//LAYOUT
let columnSpacing : CGFloat = 40
let rowSpacing : CGFloat = 500
var gridLayout : [GridItem] {
    return Array(repeating: GridItem(.flexible(),spacing: rowSpacing), count: 1)
}
//data

let manualActivity = [["name": "music relaxation","progrss": "50"],
                      ["name": "reading","progrss": "65"],
                      ["name": "hobbies","progrss": "20"],
                      ["name": "scaring videos","progrss": "10"]]

let ac : [Activity] = Bundle.main.decode("Activities.json") 
let ac2 : [Activity] = Bundle.main.decode("Activities2.json")




let autoActivity = [["name": "Workout(swwiming)","progrss": "80"]
                    ,["name": "mindnessful","progrss": "10"]]

let taskDateFormat: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateStyle = .long
       return formatter
   }()

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(secondsFromGMT: 7)
    formatter.dateFormat = "HH:mm"
    return formatter
}()

let statusCurrentUser : Bool = {
    let userDefults = UserDefaults.standard
        do {
            let userData = try userDefults.getObject(forKey: "userData", castTo: UserModel.self)
            return userData.status
        } catch {
            print(error.localizedDescription)
            return false
        }
}()
let usernameCurrentUser : String = {
    let userDefults = UserDefaults.standard
        do {
            let userData = try userDefults.getObject(forKey: "userData", castTo: UserModel.self)
            return userData.data.userName
        } catch {
            print(error.localizedDescription)
            return "-1"
        }
}()



enum NavigationTag : Int {
    case TO_BIODATA_VIEW = 1
}

