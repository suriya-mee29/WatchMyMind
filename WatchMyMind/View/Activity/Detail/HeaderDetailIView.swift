//
//  HeaderDetailIView.swift
//  WatchMyMind
//
//  Created by Suriya on 11/2/2564 BE.
//

import SwiftUI

struct HeaderDetailIView: View {
    // MARK: - PROPERTIES
    let date : Date
    let startTime : Date
    let endTime : Date
    // MARK: - BODY
    var body: some View {
        VStack {
            Text(date , formatter: taskDateFormat)
                .font(.title)
            HStack {
                HStack{
               
                    HStack {
                        Image(systemName: "stopwatch.fill")
                            .font(.caption)
                        Text(startTime,formatter: dateFormatter)
                            .font(.caption)
                        Text("-")
                            .font(.caption)
                        Image(systemName: "stopwatch.fill")
                            .font(.caption)
                        Text(endTime,formatter: dateFormatter)
                            .font(.caption)
                    }
                }
                
            }
            
            
        }
    }
}
// MARK: -PREVIEW
struct HeaderDetailIView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderDetailIView(date: Date() , startTime: Date() , endTime: Date())
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
