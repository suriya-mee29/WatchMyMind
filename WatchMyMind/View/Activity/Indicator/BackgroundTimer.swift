//
//  BackgroundTimer.swift
//  WatchMyMind
//
//  Created by Suriya on 22/2/2564 BE.
//

import SwiftUI

struct BackgroundTimer: View {
    
    @ObservedObject var stopwatch = Stopwatch()
 
    var body: some View {
        VStack {
                  Text(stopwatch.message)
                  Button(stopwatch.isRunning ? "Stop" : "Start") {
                      if stopwatch.isRunning {
                          stopwatch.stop()
                      } else {
                          stopwatch.start()
                      }
                  }
              }
    }
}

struct BackgroundTimer_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundTimer()
    }
}
