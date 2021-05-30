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
    @Published var observed :[ String] = [String]()
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
    private func getEndDate(completion : @escaping (Date,String)->Void){
       
        
        store.collection("assignment")
            .whereField("client", isEqualTo: username)
            .whereField("current", isEqualTo: true)
            .getDocuments(){ (querySnapshot, err) in
                if let err = err {
                            print("Error getting documents: \(err)")
                             completion(Date(), "")
                        } else {
                            
                           
                            for assignmentDocument in querySnapshot!.documents {
//                                print("\(assignmentDocument.documentID) => \(assignmentDocument.data())")
                                let data = assignmentDocument.data()
                                
                                if let enddate =  data["endDate"] as? Timestamp{
                                    let endDateValue = enddate.dateValue()
                                    let path = "assignment/\(assignmentDocument.documentID)/Observation"
                                    print("enddate \(path)")
                                    completion(endDateValue, path)
                                }else{
                                    
                                    completion(Date(), "")
                                }
                                
                            }
                        }
            }
        
    }
    
    
    public func saveObservedIndicator(aSleep:String = "" ,inBed:String = "",burning:String = "" ,moving:Int = 0,standing: String = "",stepping:Int = 0 ,completion : @escaping (Bool , String) -> Void){
        
        self.getEndDate(){ date, path in
            print("get date/path \(date)---\(path)")
            if path != ""{
            let toDay = Date()
            if date >= toDay {
            let key = "aDate"
            let formatter = DateFormatter()
            formatter.dateFormat = "d|MMM|y"
            let docKey = formatter.string(from: toDay)
                
            let defaults = UserDefaults.standard
            if let aDate = defaults.object(forKey: key) as? Date {
                if Calendar.current.isDateInToday(aDate){
                    // to set (update)
                    self.addObservedIndicator(aSleep: aSleep, inBed: inBed, burning: burning, moving: moving, standing: standing, stepping: stepping, path: path, key: docKey ,merge: true){ success in
                        if success {
                            completion(true,"sucess")
                            print("------- merge ------")
                        }else{
                            completion(false,"error from add new data to firebase")
                        }
                    }
                }else{
                    // add new
                    self.addObservedIndicator(aSleep: aSleep, inBed: inBed, burning: burning, moving: moving, standing: standing, stepping: stepping, path: path, key: docKey){ success in
                        if success {
                            completion(true,"sucess")
                        }else{
                            completion(false,"error from add new data to firebase")
                        }
                    }
                    
                }
                
            }else{
                // base case
                // add new
                self.addObservedIndicator(aSleep: aSleep, inBed: inBed, burning: burning, moving: moving, standing: standing, stepping: stepping, path: path, key: docKey){ success in
                    if success {
                        completion(true,"sucess")
                    }else{
                        completion(false,"error from add new data to firebase")
                    }
                }

               
            }
           
            defaults.set(toDay, forKey: key)
           }

            
           }
        }
    }
    
    private func updateObservedIndicator(aSleep:String = "" ,inBed:String = "",burning:String = "" ,moving:Int = 0,standing: String = "",stepping:Int = 0,path: String,key :String ,handerler: @escaping (Bool)->Void){
        let ref = store.collection(path).document(key)
        ref.updateData([
            "aSleep" : aSleep,
            "inBed" : inBed,
            "moving" : moving,
            "standing" : standing,
            "stepping" : stepping
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
                        handerler(false)
                
            } else {
                print("Document successfully updated")
                handerler(true)
            }
        }
    }
    private func addObservedIndicator(aSleep:String = "" ,inBed:String = "",burning:String = "" ,moving:Int = 0,standing: String = "",stepping:Int = 0,path: String,key :String , merge : Bool = false ,handerler: @escaping (Bool)->Void){
        let ref = store.collection(path).document(key)
            ref.setData([
                "aSleep" : aSleep,
                "inBed" : inBed,
                "moving" : moving,
                "standing" : standing,
                "stepping" : stepping
        ],merge: merge){ err in
            if let err = err {
                print("Error setting document: \(err)")
                handerler(false)
            } else {
                print("Document successfully setting")
                handerler(true)
            }
        }
        
    }
    
    
    
    
    public func getObserved(completion : @escaping (Bool , [String]) -> Void){
        self.observed.removeAll()
        store.collection("assignment")
            .whereField("client", isEqualTo: username)
            .whereField("current", isEqualTo: true)
            .getDocuments(){ (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }else{
                    for assignmentDocument in querySnapshot!.documents{
                        let result = assignmentDocument.data()
                        if result["observed"] != nil {
                            if let ob =  result["observed"] as? [String]{
                                for indicator in ob {
                                    self.observed.append(indicator)
                                }
                                print(self.observed)
                                completion(true ,self.observed)
                            }
                        }
                    }
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
                                                            let path = "assignment/\(AssignmentDocument.documentID)/activityList/\(dc.documentID)/results"
                                                            let obPath = "assignment/\(AssignmentDocument.documentID)/observation"
                                                            var startdate = Date()
                                                            var enddate = Date()
                                                            if let startTM = AssignmentDocument.data()["startDate"] as? Timestamp{
                                                                startdate = startTM.dateValue()
                                                            }
                                                            if let endTM = AssignmentDocument.data()["startDate"] as? Timestamp{
                                                                enddate = endTM.dateValue()
                                                            }
                                                
                                                            let autoActivityTemp = AutoActivitiesModel(createdby: createdby!, description: description!, imageIcon: imageIcon!, title: title!, type: type!, progress: progress ?? 0, everyDay: everyDay!, time: time!, round: round!, NoOfDate: NoOFDate, activityPath: path, observedPath: obPath,startDate: startdate,endDate:enddate)
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
                                                            let obPath = "assignment/\(AssignmentDocument.documentID)/observation"
                                                            var startdate = Date()
                                                            var enddate = Date()
                                                            if let startTM = AssignmentDocument.data()["startDate"] as? Timestamp{
                                                                startdate = startTM.dateValue()
                                                            }
                                                            if let endTM = AssignmentDocument.data()["startDate"] as? Timestamp{
                                                                enddate = endTM.dateValue()
                                                            }
        
                                                            let manualActivityTemp = ManualActivitiesModel(createdby: createdby, description: description!, imageIcon: imageIcon!, title: title!, type: type!, link: link, photoURL: photoURL, indicator: indicators!, progress: progress ?? 0,everyDay: everyDay!, time: time! , round: round! , NoOfDate : NoOFDate,outcomeReq: outcomeRequest, activityPath: path, observedPath: obPath,startDate: startdate,endDate:enddate)
                                                            
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
