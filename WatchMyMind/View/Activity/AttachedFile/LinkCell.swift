//
//  LinkCellView.swift
//  WatchMyMind
//
//  Created by Suriya on 23/4/2564 BE.
//

import SwiftUI
import LinkPresentation
struct LinkCell: UIViewRepresentable {
    
    var url: URL

    func makeUIView(context: Context) -> LPLinkView {

        let linkView = LPLinkView(url: url)
        let dataProvider = LPMetadataProvider()

        dataProvider.startFetchingMetadata(for: url) { (metaData, error) in
            if let metaData = metaData {
                DispatchQueue.main.async {
                    linkView.metadata = metaData
                    linkView.sizeToFit()
                }
            }
        }

        return linkView

    }

    func updateUIView(_ uiView: LPLinkView, context: Context) {}


}

struct LinkCellView_Previews: PreviewProvider {
    static var previews: some View {
           LinkCell(url: URL(string: "https://www.youtube.com/watch?v=tipcM1xPP-k")!)
       }
}
