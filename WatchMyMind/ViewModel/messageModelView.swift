//
//  messageModelView.swift
//  WatchMyMind
//
//  Created by Suriya on 16/3/2564 BE.
//

import Foundation
import SwiftUI
final class messageModelView: ObservableObject {
    
    private(set) var connectivityProvider: ConnectivityProvider
    var textFieldValue: String = ""
    
    init(connectivityProvider: ConnectivityProvider) {
        self.connectivityProvider = connectivityProvider
        self.connectivityProvider.connect()
    }
    
    func sendMessage() -> Void {
        let txt = textFieldValue
        let message = ["message":txt]
        connectivityProvider.send(message: message)
    }
}
