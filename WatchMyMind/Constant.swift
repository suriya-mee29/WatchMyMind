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
    case OTHER = 3
    case TEMPORARY = 4
    case UPLOADING = 111
    case TO_LINK_UPLAOD_VIEW = 99
    case TO_IMAGE_UPLAOD_VIEW = 100
    case TO_NOTING_VIEW = 101
    case TO_HEART_RATE_AND_TIMER_VIEW = 102
    case TO_SCALING_VIEW = 103
    case TO_ATTACHED_VIEW = 104
    
}
func getTag(navigationTag : String) -> Int {
    switch navigationTag {
    case "attached":
        return 104
    case "scaling":
        return 103
    case "hr":
        return 102
    case "noting" :
          return 101
    case "reqPhoto" :
        return 100
    case "reqLink":
        return 99
    default:
        return 0
    }
}
