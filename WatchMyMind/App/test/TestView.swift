//
//  TestView.swift
//  WatchMyMind
//
//  Created by Suriya on 24/2/2564 BE.
//

import SwiftUI



struct TestView: View {
   @ObservedObject var user = User()
    
    func test(){
        
        
    
    }
    
    var body: some View {
        VStack {
          Text("test")
               
        }
        .onAppear(perform: {
            // 1 have user in firebase Authen
           
            //1.2 username wrong
            //1.3 password wrong
            //1.4 password and username wrong
            
            // 2 havn't user in firebase Authen
            //2.2 username wrong
 
            //2.3 password wrong
            user.singIn(username: "6009650026", password: "0925954640") { (user,msg) in
                
                if user != nil {
                    DispatchQueue.main.async {
                        self.user.displayData()
                        if let currentUser = self.user.currentUser {
                           // UserDefaults.standard.set( currentUser, forKey: "current")
                        }
                        
                    }
                   
                }
                
            }
            //2.4 password and username wrong
            
           
    }) //EO-onApprar
       
        
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
