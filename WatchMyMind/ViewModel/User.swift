//
//  User.swift
//  WatchMyMind
//
//  Created by Suriya on 22/3/2564 BE.
//

import Foundation
import Firebase

class User : ObservableObject {
    @Published  var currentUser : UserModel!
    @Published var isAuthen : Bool = false
    @Published var name : String = "No Name"
    private let APIKey : String = "TU65e1f570077f0be33201447720639c54202fd702e3562b2f028583481706a462eb85b37bc82989b425fd926959ba9809"
    
    private let store = Firestore.firestore()

    
    func singIn (username: String , password: String , userData : @escaping (UserModel? , String) -> Void){
        self.fetchStdInfoFromTU_API(username: username){ (user , success, message)  in
            
            if success {
                Auth.auth().signIn(withEmail: (user?.data.email)! , password: password) { (result, error) in
                    print("firebase authen")
                    
                        if result != nil {
                            print("loged in")
                            //save user defult
                            guard let myuser = user else {
                                return
                            }
                            
                            self.saveData(newData: myuser)
                            self.isAuthen = true
                            userData(myuser , "success")
                            
                        }else {
                            print("tu authen")
                            // TU Athen
                            self.TUAuthen(username: username, password: password){
                                (tuuser ,seccess,msg) in
                                
                                if success && tuuser != nil{
                                    
                                    Auth.auth().createUser(withEmail: (user?.data.email)!, password: password) { (authDataResult, error) in
                                        print("create user")
                                        if error == nil && authDataResult != nil {
                                            print("register")
                                            //set user defult
                                            guard let myuser = user else {
                                                return
                                            }
                                            
                                            self.saveData(newData: myuser)
                                            self.createUserState(userKey: tuuser!.username , status: USER_STATUS.INACTIVE)
                                            self.isAuthen = true
                                            userData(myuser , "success")
                                            
                                            
                                            
                                        }else{
                                            print("Error: \(String(describing: error?.localizedDescription))")
                                            userData(nil ,"Error: \(String(describing: error?.localizedDescription))")
                                            
                                        }
                                    }
                                }else{
                                    // 1.3 || 2.3
                                    print("tu not notfount: \(msg)")
                                    userData(nil ,"tu not notfount: \(msg)")
                                }
                                
                                
                            }
                            
                            
                        }
                   
                }
                
            } else{
                
                //1.2 || 1.4 || 2.2 || 2.4
                // username not found
                print("not found username : \(message)")
                userData(nil ,"tu not notfount: \(message)")
            }
        }
        // fetch email by username shuch as 6009650**
      /* Auth.auth().signIn(withEmail: <#T##String#>, password: <#T##String#>, completion: <#T##((AuthDataResult?, Error?) -> Void)?##((AuthDataResult?, Error?) -> Void)?##(AuthDataResult?, Error?) -> Void#>)*/
    }
    func displayData(){
        print(currentUser.timestamp)
        print(currentUser.status)
        print(currentUser.message)
        print(currentUser.data.statusid)
        print(currentUser.data.statusname)
        print(currentUser.data.displayname_en)
    }
    
    func getUserSatus(username : String , completion : @escaping (String) -> Void) {
        let docRef = store.collection("users").document(username)
        var status : String = "not found"
        DispatchQueue.main.async {
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    
                   // print("Document data: \(dataDescription)")
                    let statuss = document.data()! as? [String : String]
                    
                    status = (statuss?["status"])!
                    completion(status)
                } else {
                    //print("Document does not exist")
                   
                }
            }
       
           
        }
       
    }
    
    private func saveData (newData : UserModel){
        DispatchQueue.main.async {
            self.currentUser = newData
            if let userData = self.currentUser {
                let userDefaults = UserDefaults.standard
                do {
                    try userDefaults.setObject(userData, forKey: "userData")
                    print("save user data")
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
            self.displayData()
        }
    }
    
    private func createUserState(userKey : String , status : USER_STATUS ){
        print("create user")
        
        let loadData :[String : String ] = [
            "status" : "\(status.rawValue)",
            "type" : "client"
        ]
        
        store.collection("users").document("\(userKey)").setData(loadData){ error in
            print("-->\(error)")
        }
           
    }
    // MARK: - TU API SERVICE
    private func TUAuthen(username: String , password : String , completion : @escaping (TUUser? ,Bool,String) -> Void ){
        let url = URL(string: TUStdAuthen)
        guard let requestUrl = url else { fatalError("request url:\(url?.absoluteString ?? "error") is false ") }
        
        var req = URLRequest(url: requestUrl)
        
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue(APIKey, forHTTPHeaderField: "Application-Key")
        
        let body = ["UserName": "\(username)" ,
                    "PassWord": "\(password)"]
        
        let bodyData = try? JSONSerialization.data(
            withJSONObject: body,
            options: []
        )
        req.httpBody = bodyData
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
         
                // Convert HTTP Response Data to a String
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    //print("Response data string:\n \(dataString)")
                    
                     if let res = response as? HTTPURLResponse{
                       if res.statusCode == 200 {
                        let myData = Data(dataString.utf8)
                        let myuser : TUUser = Bundle.main.decodev2(myData)
                        completion(myuser,true,"seccess")
                        
                       }else {
                        // wrong
                        completion(nil ,false,dataString)
                       }
                    }
                }
        }
        task.resume()
    }
    private func fetchStdInfoFromTU_API(username: String , completion : @escaping (UserModel? ,Bool,String) -> Void ){
        // Create URL
        let url = URL(string: "\(stdInfoURL)\(username)")
        guard let requestUrl = url else { fatalError("request url:\(url?.absoluteString ?? "error") is false ") }
        
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(APIKey, forHTTPHeaderField: "Application-Key")
        
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
        
            // Convert HTTP Response Data to UserModel
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                // caovert to json
                if let  res = response as? HTTPURLResponse{
                    print(res.statusCode)
                    if res.statusCode == 200 {
                        print("\(dataString)")
                        let myData = Data(dataString.utf8)
                        let myUser : UserModel = Bundle.main.decodev2(data)
                        self.name = myUser.data.displayname_en
                        completion(myUser, true , "seccess")
                    }else{
                        // not fount or ..
                        completion( nil , false , dataString)
                        
                    }
                }
               
                
            }else{
                completion( nil , false , "")
            }
            
            
        }
        task.resume()
    }
    
}
