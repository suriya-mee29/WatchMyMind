//
//  NavView.swift
//  WatchMyMind
//
//  Created by Suriya on 3/3/2564 BE.
//

import SwiftUI

struct NavView: View {
    // MARK: - PROPERTIES
    
    @State var isDate : Bool = false
    @State  var action: Int? = 0
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var MindfulnessCollection : FetchedResults<Mindfulness>
    
    // MARK: - BODY
    var body: some View {
        VStack{
            NavigationLink(destination:
                           Text("ssss")
                           , tag: 1, selection: $action){
                EmptyView()
            }
            NavigationLink(destination:
                            BioDataListView(headline: "BREATHING", isActivity: false).environment(\.managedObjectContext, viewContext)
                           , tag: 2, selection: $action){
                EmptyView()
                
            }
        }.onAppear(perform: {
            if MindfulnessCollection.count != 0 {
                // have the data
                MindfulnessCollection.forEach { mf in
                    if let date = mf.date {
                     if Calendar.current.isDateInToday(date){
                        self.isDate = true
                     }
                  }
                }// :LOOP
                if isDate{
                    self.action = 2
                }else{
                    self.action = 1
                }

            }else{ // collection is 0
                action = 1
                
            }
            
        })
    }
}
    // MARK: -PREVIEW
struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
    }
}
