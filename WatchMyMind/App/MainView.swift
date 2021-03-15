//
//  MainView.swift
//  WatchMyMind
//
//  Created by Suriya on 15/3/2564 BE.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        TabView{
            HomeView().environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Image(systemName: "house")
                   Text("home")
                }
            Text("Hello, Worldeeee")
                .tabItem {
                    Image(systemName: "homekit")
                   Text("home")
                }

        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
