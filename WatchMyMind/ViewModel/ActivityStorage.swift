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
    
    
    func saveResults (path:String , results : [String: Any] ,completion : @escaping(Bool,String)->Void){
        print("activity save data")
        
        docRef.collection(path).addDocument(data: results){ error in
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
    func uploadImage(data:Data , filename : String ,completion : @escaping(Bool,String?)->Void)  {
        let storageRef = storage.reference()
        let dir = "attachedFiles"
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("\(dir)/\(filename).jpg")
        
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
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
    }//eof - uploadImage
}
