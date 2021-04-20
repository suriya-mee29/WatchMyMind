//
//  ProgassView.swift
//  WatchMyMind
//
//  Created by Suriya on 30/3/2564 BE.
//

import SwiftUI

struct ProgassView: View {
    var body: some View {
        ZStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                .scaleEffect(3)
                .padding(.vertical,90)
                .padding(.horizontal,90)
        }
        .background(Color.gray.opacity(0.5))
                .cornerRadius(20)
    }
}

struct ProgassView_Previews: PreviewProvider {
    static var previews: some View {
        ProgassView().previewLayout(.sizeThatFits)
    }
}
