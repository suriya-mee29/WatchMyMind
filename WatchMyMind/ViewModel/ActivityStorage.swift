//
//  ActivityStorage.swift
//  WatchMyMind
//
//  Created by Suriya on 3/5/2564 BE.
//

import Foundation
import Firebase

class ActivityStorage : ObservableObject {
    private let docRef = Firestore.firestore()
    private let storage = Storage.storage()
    @Published  var percentComplete : Double = 0
    var indicator : [String: Any] =  [String: Any]()
    var path : String = ""
    var timer : Timer?
 
    func saveResults (path:String , results : [String: Any] ,completion : @escaping(Bool,String)->Void){
        print("activity save data")
        
       let df = docRef.collection(path).addDocument(data: results){ error in
            if let error = error {
                    print("Error adding document: \(error)")
                completion(false , error.localizedDescription)
                } else {
                   
                    print("Document successfully written!")
                    completion(true , "")
                }
        }
    }
    ///uploading am image to database
    func uploadImage( _ url:URL , filename : String ,completion : @escaping(Bool,String?)->Void)  {
        let storageRef = storage.reference()
        let dir = "attachedFiles"
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("\(dir)/\(filename).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putFile(from: url, metadata: metadata) { (metadata, error) in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            completion(false,error?.localizedDescription)
            return
          }
            
            // Metadata contains file metadata such as size, content-type.
              let size = metadata.size
              // You can also access to download URL after upload.
              riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                  // Uh-oh, an error occurred!
                    completion(false,error?.localizedDescription)
                  return
                }
                completion(true,downloadURL.absoluteString)
              }
        }
        uploadTask.observe(.progress) { snapshot in
          // Upload reported progress
            self.percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
            / Double(snapshot.progress!.totalUnitCount)
            
        }
    }//eof - uploadImage
    
    func activityCount(path:String ,completion : @escaping(Bool,Int)->Void){
        var couter = 0
        let df = docRef.collection(path).getDocuments { querySnapshot, error in
            if let snapshot = querySnapshot {
                for document in snapshot.documents{
                    couter += 1
                    
                }
                completion(true,couter)
            }else{
                completion(false,-1)
            }
        }
        
        
    }
    func setResults(path:String , results : [[String: Any]] ,completion : @escaping(Bool,String)->Void){
        
        if results.count != 0{
            for i in 0...(results.count-1){
                let data = results[i]
                let id = data["date"] as? Date
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm d|MMM|y"
                let docKey = formatter.string(from: id ?? Date())
                print("docKey-----\(docKey)")
                print("path----\(path)")
                let df = docRef.collection(path).document(docKey).setData(data){ err in
                    if let err = err {
                        print("Error writing document: \(err)")
                        completion(false,"Error writing document: \(err)")
                    } else {
                        print("Document successfusample.startDatelly written!")
                        completion(true,"Document successfully written!")
                    }
                }
                
                
            }
            
        }else{
            completion(false,"results are index out of ground")
        }
       // let df = docRef.collection(path).document("").setData()
    }
    
}
