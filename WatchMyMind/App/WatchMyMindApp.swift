//
//  WatchMyMindApp.swift
//  WatchMyMind
//
//  Created by Suriya on 27/1/2564 BE.
//

import SwiftUI
import Firebase


@main
struct WatchMyMindApp: App {
    let presistenContainer = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
   
    init() {
        FirebaseApp.configure()
        
       
    }
    var body: some Scene {
        
        WindowGroup {
            //HomeView()
               // .environment(\.managedObjectContext, presistenContainer.container.viewContext)
             
                ContentView()
                    .environment(\.managedObjectContext, presistenContainer.container.viewContext)
            
         //   WatingView()
                
        //    TestView()
                
        }

        .onChange(of: scenePhase) { (phase) in
                   switch phase {
                   case .active: print("ScenePhase: active")
                   case .background: print("ScenePhase: background")
                   case .inactive: print("ScenePhase: inactive")
                   @unknown default: print("ScenePhase: unexpected state")
                   }
        }
    }
}
        
