//
//  TestView.swift
//  WatchMyMind
//
//  Created by Suriya on 24/2/2564 BE.
//

import SwiftUI



struct TestView: View {
    @ObservedObject var messageMV : messageModelView
   
    var body: some View {
        VStack {
                 TextField("Message Content", text: $messageMV.textFieldValue)
                 
                 Button(action: {
                     self.messageMV.sendMessage()
                 }) {
                     Text("Send Message")
                 }
             }
        
        
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
       // TestView()
        Text("dd")
    }
}
