//
//  ConnectivityProvider.swift
//  WatchMyMind
//
//  Created by Suriya on 16/3/2564 BE.
//

import Foundation
import WatchConnectivity

class ConnectivityProvider: NSObject, WCSessionDelegate {
    
    private let session: WCSession
    
    init(session: WCSession = .default) {
            self.session = session
            super.init()
            self.session.delegate = self
            self.connect()
        
        }
    
    func send(message: [String:Any]) -> Void {
        session.sendMessage(message, replyHandler: nil) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // code
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        // code
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // code
    }
    func connect() {
        print("active")
           guard WCSession.isSupported() else {
               print("WCSession is not supported")
               return
           }
        print("actived----------")
           session.activate()
       }
}
