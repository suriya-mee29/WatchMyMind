//
//  HealthKitExtension.swift
//  WatchMyMind
//
//  Created by Suriya on 17/3/2564 BE.
//

import Foundation
import HealthKit

extension HKWorkoutActivityType {
    
    /*
     Simple mapping of available workout types to a human readable name.
     */
    var name: String {
        switch self {
        case .americanFootball:             return "American Football"
        case .archery:                      return "Archery"
        case .australianFootball:           return "Australian Football"
            
        case .badminton:                    return "Badminton"
        case .barre:                        return "Barre"
        case .baseball:                     return "Baseball"
        case .basketball:                   return "Basketball"
        case .bowling:                      return "Bowling"
        case .boxing:                       return "Boxing"
            
        case .climbing:                     return "Climbing"
        case .cooldown:                     return "Cooldown"
        case .coreTraining:                 return "Core Training"
        case .cricket:                      return "Cricket"
        case .crossCountrySkiing:           return "Cross Country Skiing"
        case .crossTraining:                return "Cross Training"
        case .curling:                      return "Curling"
        case .cycling:                      return "Cycling"
        case .cardioDance:                  return "Cardio Dance"
            
     
        case .discSports:                   return "Disc Sports"
        case .downhillSkiing:               return "Downhill Skiing"
            
        case .elliptical:                   return "Elliptical"
        case .equestrianSports:             return "Equestrian Sports"
            
        case .fencing:                      return "Fencing"
        case .fishing:                      return "Fishing"
        case .functionalStrengthTraining:   return "Functional Strength Training"
            

        case .golf:                         return "Golf"
        case .gymnastics:                   return "Gymnastics"
        
        case .handball:                     return "Handball"
        case .hiking:                       return "Hiking"
        case .hockey:                       return "Hockey"
        case .hunting:                      return "Hunting"
        case .handCycling:                  return "Hand Cycling"
        case .highIntensityIntervalTraining:return "Hight Intensity Interval Training"
            
        case .jumpRope:                     return "Jump Rope"
            
        case .kickboxing:                   return "Kickboxing"
        
        case .lacrosse:                     return "Lacrosse"
        
        case .martialArts:                  return "Martial Arts"
        case .mindAndBody:                  return "Mind and Body"
        case .mixedCardio:                  return "mixed Cardio"
        
            
        case .other:                        return "Other"
        
        case .paddleSports:                 return "Paddle Sports"
        case .play:                         return "Play"
        case .preparationAndRecovery:       return "Preparation and Recovery"
        case .pilates:                      return "Pilates"
        case .pickleball:                   return "Pickleball"
    
        case .racquetball:                  return "Racquetball"
        case .rowing:                       return "Rowing"
        case .rugby:                        return "Rugby"
        case .running:                      return "Running"
        
        case .sailing:                      return "Sailing"
        case .skatingSports:                return "Skating Sports"
        case .snowSports:                   return "Snow Sports"
        case .soccer:                       return "Soccer"
        case .softball:                     return "Softball"
        case .squash:                       return "Squash"
        case .stairClimbing:                return "Stair Climbing"
        case .surfingSports:                return "Surfing Sports"
        case .swimming:                     return "Swimming"
        case .stairs:                       return "Stairs"
        case .snowboarding:                 return "Snow Boarding"
        case .stepTraining:                 return "Step Training"
        case .socialDance:                  return "Social Dance"
        
        case .tableTennis:                  return "Table Tennis"
        case .tennis:                       return "Tennis"
        case .trackAndField:                return "Track and Field"
        case .traditionalStrengthTraining:  return "Traditional Strength Training"
        case .taiChi:                       return "Tai Chi"
        
        case .volleyball:                   return "Volleyball"
        
        case .walking:                      return "Walking"
        case .waterFitness:                 return "Water Fitness"
        case .waterPolo:                    return "Water Polo"
        case .waterSports:                  return "Water Sports"
        case .wrestling:                    return "Wrestling"
        case .wheelchairRunPace:            return "Wheelchair Run Pace"
        case .wheelchairWalkPace:           return "Wheelchair Walk Pace"
        
        case .yoga:                         return "Yoga"
        
        // Catch-all
        default:                            return "Other"
        }
    }
    
    /*
     Additional mapping for common name for activity types where appropriate.
     */
    var commonName: String {
        switch self {
        case .highIntensityIntervalTraining: return "HIIT"
        default: return name
        }
    }
    
    /*
     Mapping of available activity types to emojis, where an appropriate gender-agnostic emoji is available.
     */
    var associatedEmoji: String? {
        switch self {
        case .americanFootball:             return "🏈"
        case .archery:                      return "🏹"
        case .badminton:                    return "🏸"
        case .baseball:                     return "⚾️"
        case .basketball:                   return "🏀"
        case .bowling:                      return "🎳"
        case .boxing:                       return "🥊"
        case .curling:                      return "🥌"
        case .cycling:                      return "🚲"
        case .equestrianSports:             return "🏇"
        case .fencing:                      return "🤺"
        case .fishing:                      return "🎣"
        case .functionalStrengthTraining:   return "💪"
        case .golf:                         return "⛳️"
        case .hiking:                       return "🥾"
        case .hockey:                       return "🏒"
        case .lacrosse:                     return "🥍"
        case .martialArts:                  return "🥋"
        case .mixedMetabolicCardioTraining: return "❤️"
        case .paddleSports:                 return "🛶"
        case .rowing:                       return "🛶"
        case .rugby:                        return "🏉"
        case .sailing:                      return "⛵️"
        case .skatingSports:                return "⛸"
        case .snowSports:                   return "🛷"
        case .soccer:                       return "⚽️"
        case .softball:                     return "🥎"
        case .tableTennis:                  return "🏓"
        case .tennis:                       return "🎾"
        case .traditionalStrengthTraining:  return "🏋️‍♂️"
        case .volleyball:                   return "🏐"
        case .waterFitness, .waterSports:   return "💧"
        
        // iOS 10
        case .barre:                        return "🥿"
        case .crossCountrySkiing:           return "⛷"
        case .downhillSkiing:               return "⛷"
        case .kickboxing:                   return "🥋"
        case .snowboarding:                 return "🏂"
        
        // iOS 11
        case .mixedCardio:                  return "❤️"
        
        // iOS 13
        case .discSports:                   return "🥏"
        case .fitnessGaming:                return "🎮"
        
        // Catch-all
        default:                            return nil
        }
    }
    
    var associatedIcon : String? {
        switch self {
        case .americanFootball:             return "americanFootball"
        case .archery:                      return "archery"
        case .australianFootball:           return "australianFootball"
            
        case .badminton:                    return "badminton"
        case .barre:                        return "barre"
        case .baseball:                     return "baseball"
        case .basketball:                   return "basketball"
        case .bowling:                      return "bowling"
        case .boxing:                       return "boxing"
            
        case .climbing:                     return "climbing"
        case .cooldown:                     return "cooldown"
        case .coreTraining:                 return "coreTraining"
        case .cricket:                      return "cricket"
        case .crossCountrySkiing:           return "crossCountrySkiing"
        case .crossTraining:                return "crossTraining"
        case .curling:                      return "curling"
        case .cycling:                      return "cycling"
        case .cardioDance:                  return "cardio Dance"
            
     
        case .discSports:                   return "discSports"
        case .downhillSkiing:               return "downhillSkiing"
            
        case .elliptical:                   return "elliptical"
        case .equestrianSports:             return "equestrianSports"
            
        case .fencing:                      return "fencing"
        case .fishing:                      return "fishing"
        case .functionalStrengthTraining:   return "functionalStrengthTraining"
            

        case .golf:                         return "golf"
        case .gymnastics:                   return "gymnastics"
        
        case .handball:                     return "handball"
        case .hiking:                       return "hiking"
        case .hockey:                       return "hockey"
        case .hunting:                      return "hunting"
        case .handCycling:                  return "handCycling"
        case .highIntensityIntervalTraining:return "hightIntensityIntervalTraining"
            
        case .jumpRope:                     return "jumpRope"
            
        case .kickboxing:                   return "kickboxing"
        
        case .lacrosse:                     return "lacrosse"
        
        case .martialArts:                  return "martialArts"
        case .mindAndBody:                  return "mindandBody"
        case .mixedCardio:                  return "mixedCardio"
        
            
        case .other:                        return "other"
        
        case .paddleSports:                 return "paddleSports"
        case .play:                         return "play"
        case .preparationAndRecovery:       return "preparationAndRecovery"
        case .pilates:                      return "pilates"
        case .pickleball:                   return "pickleball"
    
        case .racquetball:                  return "racquetball"
        case .rowing:                       return "rowing"
        case .rugby:                        return "rugby"
        case .running:                      return "running"
        
        case .sailing:                      return "sailing"
        case .skatingSports:                return "skatingSports"
        case .snowSports:                   return "snowSports"
        case .soccer:                       return "soccer"
        case .softball:                     return "softball"
        case .squash:                       return "squash"
        case .stairClimbing:                return "stairClimbing"
        case .surfingSports:                return "surfingSports"
        case .swimming:                     return "swimming"
        case .stairs:                       return "stairs"
        case .snowboarding:                 return "snowBoarding"
        case .stepTraining:                 return "stepTraining"
        case .socialDance:                  return "socialDance"
        
        case .tableTennis:                  return "tableTennis"
        case .tennis:                       return "tennis"
        case .trackAndField:                return "trackAndField"
        case .traditionalStrengthTraining:  return "traditionalStrengthTraining"
        case .taiChi:                       return "taiChi"
        
        case .volleyball:                   return "volleyball"
        
        case .walking:                      return "walking"
        case .waterFitness:                 return "waterFitness"
        case .waterPolo:                    return "waterPolo"
        case .waterSports:                  return "waterSports"
        case .wrestling:                    return "wrestling"
        case .wheelchairRunPace:            return "wheelchairRunPace"
        case .wheelchairWalkPace:           return "wheelchairWalkPace"
        
        case .yoga:                         return "yoga"

        // Catch-all
        default:                            return "other"
    }
    
    
    enum EmojiGender {
        case male
        case female
    }
    
    /*
     Mapping of available activity types to appropriate gender specific emojies.
     
     If a gender neutral symbol is available this simply returns the value of `associatedEmoji`.
     */
    func associatedEmoji(for gender: EmojiGender) -> String? {
        switch self {
        case .climbing:
            switch gender {
            case .female:                   return "🧗‍♀️"
            case .male:                     return "🧗🏻‍♂️"
            }
        case .dance, .danceInspiredTraining:
            switch gender {
            case .female:                   return "💃"
            case .male:                     return "🕺🏿"
            }
        case .gymnastics:
            switch gender {
            case .female:                   return "🤸‍♀️"
            case .male:                     return "🤸‍♂️"
            }
        case .handball:
            switch gender {
            case .female:                   return "🤾‍♀️"
            case .male:                     return "🤾‍♂️"
            }
        case .mindAndBody, .yoga, .flexibility:
            switch gender {
            case .female:                   return "🧘‍♀️"
            case .male:                     return "🧘‍♂️"
            }
        case .preparationAndRecovery:
            switch gender {
            case .female:                   return "🙆‍♀️"
            case .male:                     return "🙆‍♂️"
            }
        case .running:
            switch gender {
            case .female:                   return "🏃‍♀️"
            case .male:                     return "🏃‍♂️"
            }
        case .surfingSports:
            switch gender {
            case .female:                   return "🏄‍♀️"
            case .male:                     return "🏄‍♂️"
            }
        case .swimming:
            switch gender {
            case .female:                   return "🏊‍♀️"
            case .male:                     return "🏊‍♂️"
            }
        case .walking:
            switch gender {
            case .female:                   return "🚶‍♀️"
            case .male:                     return "🚶‍♂️"
            }
        case .waterPolo:
            switch gender {
            case .female:                   return "🤽‍♀️"
            case .male:                     return "🤽‍♂️"
            }
        case .wrestling:
            switch gender {
            case .female:                   return "🤼‍♀️"
            case .male:                     return "🤼‍♂️"
            }

        // Catch-all
        default:                            return ""
        }
    }
    
}
}
