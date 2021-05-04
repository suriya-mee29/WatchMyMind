//
//  TextRecognition.swift
//  WatchMyMind
//
//  Created by Suriya on 30/4/2564 BE.
//

import Foundation
class TextRecognition: ObservableObject {
    let API_KEY = "ejaBWl1XONSdM2iBMrj7Jhisurd1h0li"
    
    public func SSense(text: String , completion : @escaping(SsenseModel?) ->Void ){
        let myText = text.unicodeScalars
            .filter { !$0.properties.isEmojiPresentation}
            .reduce("") { $0 + String($1) }
        
        let queryItems = [URLQueryItem(name: "text", value: myText)]
        var urlComps = URLComponents(string: APIForThai_SSENSE)!
        urlComps.queryItems = queryItems
     
        let url = urlComps.url
        guard let requestUrl = url else { fatalError("request url:\(url?.absoluteString ?? "error") is false ") }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(self.API_KEY, forHTTPHeaderField: "Apikey")
        
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            // Convert HTTP Response Data to UserModel
            if let data = data , let dataString = String(data: data, encoding: .utf8) {
                // caovert to json
                if let  res = response as? HTTPURLResponse{
                    print(res.statusCode)
                    if res.statusCode == 200 {
                        print("\(dataString)")
                         //let myData = Data(dataString.utf8)
                        
                         let ssense : SsenseModel = Bundle.main.decodev2(data)
//                        let myUser : UserModel = Bundle.main.decodev2(data)
                        
                       completion(ssense)
                    }else{
                        // not fount or ..
                        completion(nil)
                        print("error")
                        
                    }
                }
               
                
            }else{
                print("false")
                completion(nil)
              
            }
        }
        task.resume()
    }
}
