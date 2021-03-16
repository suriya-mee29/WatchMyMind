//
//  WatchMyMindApp.swift
//  WatchMyMind
//
//  Created by Suriya on 27/1/2564 BE.
//

import SwiftUI


@main
struct WatchMyMindApp: App {
    let presistenContainer = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    let mv = messageModelView(connectivityProvider: ConnectivityProvider())
    var body: some Scene {
        
        
        WindowGroup {
           
            TestView(messageMV: mv)
           // HomeView()
               // .environment(\.managedObjectContext, presistenContainer.container.viewContext)
                
        }

    /*    .onChange(of: scenePhase) { (phase) in
                   switch phase {
                   case .active: print("ScenePhase: active")
                   case .background: print("ScenePhase: background")
                   case .inactive: print("ScenePhase: inactive")
                   @unknown default: print("ScenePhase: unexpected state")
                   }
        }*/
    }
}
        
