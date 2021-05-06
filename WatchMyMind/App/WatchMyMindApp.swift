//
//  WatchMyMindApp.swift
//  WatchMyMind
//
//  Created by Suriya on 27/1/2564 BE.
//
//Copyright (c) 2014-2020 Bibin Jacob Pulickal (http://github.com/bibinjacobpulickal)
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

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
                
            //TestView()
                
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
        
