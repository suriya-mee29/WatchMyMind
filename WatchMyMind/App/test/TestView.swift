//
//  TestView.swift
//  WatchMyMind
//
//  Created by Suriya on 24/2/2564 BE.
//

import SwiftUI
import CombineSchedulers


struct TestView: View {
    private var healthStore : HealthStore?
    @ObservedObject var autoActivityStore : AutoActivityStore
    @State private var data : String = "0"
    init() {
        healthStore = HealthStore()
        autoActivityStore = AutoActivityStore(autoActivityCollection: [])
    }
    func test(){
        
        
    
    }
    
    var body: some View {
        VStack {
            Text(data)
            Button(action: {
                self.autoActivityStore.displayData()
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
               
        }
        .onAppear(perform: {
            autoActivityStore.loadData(startDate: Date(), numberOfObserved: -7)
            autoActivityStore.displayData()
           
    }) // onApprar
       
        
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
