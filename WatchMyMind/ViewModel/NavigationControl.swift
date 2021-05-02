//
//  NavigationControl.swift
//  WatchMyMind
//
//  Created by Suriya on 2/5/2564 BE.
//

import Foundation
class NavigationControl: ObservableObject {
    ///status on root view
    @Published var rootActive : Bool
    
    init() {
        rootActive = false
    }
    
    func dismiss(){
        rootActive = false
    }
}
