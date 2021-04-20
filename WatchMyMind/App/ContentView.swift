//
//  ContentView.swift
//  WatchMyMind
//
//  Created by Suriya on 27/1/2564 BE.
//

import SwiftUI
import Firebase

struct ContentView: View {
    // MARK: - PROPERTIES
    @State var isAuthen : Bool = statusCurrentUser
    @State private var username : String = ""
    @State private var password : String = ""
    @State var dt : UserModel?
    
    
    @State var user = User()
    @Environment(\.managedObjectContext) private var viewContext
   
    init() {
        print("status--> \(isAuthen)")
        
    }
    func getstatus()-> Bool{
        return false
    }

    
    // MARK: - BODY
    var body: some View {
        ZStack{
            
            if isAuthen {
                HomeView( isAuthen: $isAuthen, user: $user, dt: $dt ).environment(\.managedObjectContext, viewContext)
                
            }else{
                
                LoginView(isAuthen: $isAuthen, dt: $dt )
                
            }
            
        }.onAppear{
         
           
        }
            
    }
}

// MARK: -PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
