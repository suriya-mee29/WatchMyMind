//
//  ActivitiesListViewModel.swift
//  WatchMyMind
//
//  Created by Suriya on 20/4/2564 BE.
//
import SwiftUI
import Firebase

class ActivitiesListViewModel : ObservableObject{
    
    @Published var autoActivities : [AutoActivitiesModel]?
    @Published var manualActivities : [ManualActivitiesModel]?
    private let store = Firestore.firestore()
    let username : String
    
     var startDate = Date()
     var endDate = Date()
     var appointmentDate = Date()
    

    init(username : String) {
       autoActivities = []
       manualActivities = []
       self.username = username
       self.getActivitiesList(){ (success, err)  in
            if success {
           print("success from init")
        
            }else{
            print("error from init : \(err)")
            }
            
            
        }
    }
    
    public func getActivitiesList(completion : @escaping (Bool , String) -> Void){
    
            self.autoActivities?.removeAll()
            self.manualActivities?.removeAll()
        
        store.collection("assignment")
            .whereField("client", isEqualTo: username)
            .whereField("current", isEqualTo: true)
            .getDocuments(){ (querySnapshot, err) in
                if let err = err {
                    
                            print("Error getting documents: \(err)")
                    completion(false,err.localizedDescription)
                        } else {
                            
                            
                            for AssignmentDocument in querySnapshot!.documents {
                               // print("\(AssignmentDocument.documentID) => \(AssignmentDocument.data())")
                                
                                if let startTimestamp =  AssignmentDocument.data()["startDate"] as? Timestamp {
                                    self.startDate = startTimestamp.dateValue()
                                }
                          
                                
                                if let endTimestamp = AssignmentDocument.data()["endDate"] as? Timestamp {
                                    self.endDate = endTimestamp.dateValue()
                                }
                                
                                
                                if let appointmentTimestamp = AssignmentDocument.data()["appointmentDate"] as? Timestamp {
                                    self.appointmentDate = appointmentTimestamp.dateValue()
                                }
        
                                self.store.collection("assignment/\(AssignmentDocument.documentID)/activityList")
                                    .getDocuments(){ [self] (qs , error) in
                                        if error == nil {
                                        for dc in qs!.documents{
                                           // print("\(dc.documentID) => \(dc.data())")
                                            
                                            if let dcRef = dc["activities"] as? DocumentReference {
                                                   // print("RefID-->\(dcRef.documentID)")
                                                
                                                dcRef.getDocument { (documentSnapshot, dcRefError) in
                                                    if dcRefError == nil {
                                                        let activity = documentSnapshot?.data()
                                                        
                                                        if activity!["type"] as? String == activityType.AUTO.rawValue {
                                                            //AUTO
                                                            //Retrive data to AutoActivitiesMode
                                                            let createdby = activity!["createdby"] as? String
                                                            let description = activity!["description"] as? String
                                                            let imageIcon = activity!["imageIcon"] as? String
                                                            let title = activity!["title"] as? String
                                                            let type = activity!["type"] as? String
                                                            let progress = dc.data()["progress"] as? Int
                                                            
                                                            //fequency
                                                            let everyDay = dc.data()["everyDay"] as? Bool
                                                            let time = dc.data()["time"] as? Int
                                                            let round = dc.data()["round"] as? Int
                                                            
                                                            var NoOFDate = 0
                                                            if (dc.data()["NoOfDate"] as? Int) != nil {
                                                                NoOFDate = (dc.data()["NoOfDate"] as? Int)!
                                                            }
                                                
                                                            let autoActivityTemp = AutoActivitiesModel(createdby: createdby!, description: description!, imageIcon: imageIcon!, title: title!, type: type!, progress: progress!, everyDay: everyDay!, time: time!, round: round!, NoOfDate: NoOFDate)
                                                            self.autoActivities?.append(autoActivityTemp)
                                                            
                                                        }else{
                                                           //MANUAL
                                                           //Retrive data to ManualActivitiesMode
                                                            var createdby = ""
                                                            
                                                            if let user  = activity!["createdby"]  as? DocumentReference{
                                                              //  print("createdby<-->psychologist")
                                                                createdby = user.documentID
                                                            }
                                                            
                                                            let description = activity!["description"] as? String
                                                            let imageIcon = activity!["imageIcon"] as? String
                                                            let title = activity!["title"] as? String
                                                            let type = activity!["type"] as? String
                                                           
                                                           // optional data
                                                            var link = ""
                                                            var photoURL = ""
                                                            
                                                            if activity!["link"] != nil{
                                                                link = (activity!["link"] as? String)!
                                                            }
                                                            if activity!["photoURL"] != nil{
                                                                photoURL = (activity!["photoURL"] as? String)!
                                                            }
                                                            
                                                            // indicator
                                                            let indicators = dc.data()["indicator"] as? [String]
                                                            let progress = dc.data()["progress"] as? Int
                                                            
                                                            //fequency
                                                            let everyDay = dc.data()["everyDay"] as? Bool
                                                            let time = dc.data()["time"] as? Int
                                                            let round = dc.data()["round"] as? Int
                                                            
                                                            var NoOFDate = 0
                                                            if (dc.data()["NoOfDate"] as? Int) != nil {
                                                                NoOFDate = (dc.data()["NoOfDate"] as? Int)!
                                                            }
                                                            
                                                            //outcome request
                                                            var outcomeRequest = [String]()
                                                            if (activity!["outcomeReq"] as? [String]) != nil{
                                                                outcomeRequest = (activity!["outcomeReq"] as? [String])!
                                                                
                                                            }
                                                            let path = "assignment/\(AssignmentDocument.documentID)/activityList/\(dc.documentID)/results"
                                                            print("path --> \(path)")
        
                                                            let manualActivityTemp = ManualActivitiesModel(createdby: createdby, description: description!, imageIcon: imageIcon!, title: title!, type: type!, link: link, photoURL: photoURL, indicator: indicators!, progress: progress!,everyDay: everyDay!, time: time! , round: round! , NoOfDate : NoOFDate,outcomeReq: outcomeRequest, activityPath: path)
                                                            
                                                            self.manualActivities?.append(manualActivityTemp)
                                                            
                                                        }
                                                        
                                                       // print("into--> \(documentSnapshot?.data())")
                                                        
                                                    }else{
                                                        print(dcRefError?.localizedDescription)
                                                        completion(false , "")
                                                    }
                                                }// eof - documentSnapshot
                                                
                                                     
                                                }
                                            
                                        }// eof - dc : list of activity
                                            print("----------completion---------------")
                                            print(self.autoActivities ?? [])
                                            print(self.manualActivities ?? [])
                                            completion(true ,  "")
                                        } else{
                                            completion(false , error?.localizedDescription ?? "error")
                                        }
                                    }
                                
                            }
                            
                        }
            }
        
    }
    
   
    
    
}
