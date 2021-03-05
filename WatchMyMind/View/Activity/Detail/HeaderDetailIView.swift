//
//  HeaderDetailIView.swift
//  WatchMyMind
//
//  Created by Suriya on 11/2/2564 BE.
//

import SwiftUI

struct HeaderDetailIView: View {
    // MARK: - PROPERTIES
    let date : String
    let time : String
    let location : String
    // MARK: - BODY
    var body: some View {
        VStack {
            Text(date)
                .font(.title)
            HStack {
                HStack{
                    Image(systemName: "stopwatch.fill")
                        .font(.caption)
                    Text(time)
                        .font(.caption)
                }
                HStack{
                    Image(systemName: "location.fill")
                        .font(.caption)
                        .lineLimit(1)
                    Text(location)
                        .font(.caption)
                }
            }
            
            
        }
    }
}
// MARK: -PREVIEW
struct HeaderDetailIView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderDetailIView(date: "11 November 2020", time: "08:00 - 08:05", location: "Khlong Luang")
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
