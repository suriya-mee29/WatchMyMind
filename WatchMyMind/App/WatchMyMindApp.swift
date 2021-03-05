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

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, presistenContainer.container.viewContext)
        }
    }
}
        
