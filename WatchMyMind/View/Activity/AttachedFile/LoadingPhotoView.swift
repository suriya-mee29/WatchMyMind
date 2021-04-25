//
//  AttachedFileView.swift
//  WatchMyMind
//
//  Created by Suriya on 23/4/2564 BE.
//

import SwiftUI
import LinkPresentation

struct LoadingPhotoView: View {
    let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/watchmymind-9a4de.appspot.com/o/attachedFiles%2F9565BEE7-C227-4CDD-8A87-1D1E2086959C.jpg?alt=media&token=4f0d8d8f-f36a-4358-8615-aacb372e7581")!
    
    var body: some View {
        AsyncImage(url: url) {
            HStack {
                ProgressView()
                Text(" loading")
            }
        }
        .padding()
    }
}
// MARK: - PROPERTIES
struct LoadingPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingPhotoView()
    }
}
