//
//  HomeView.swift
//  WatchMyMind
//
//  Created by Suriya on 29/1/2564 BE.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - PROPERTIES
    @ObservedObject var activityVM = ActivityViewModel()
    @State public var showDescriptionView: Bool = false
    @State var isNewTripPresented = false
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                    VStack (spacing:0){
                        ZStack (alignment: .top){
                            
                            NavigationBarView()
                                .padding(.top)
                                .zIndex(1)
                            
                            HeaderView()
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5 )
                        }
                        ScrollView(.vertical, showsIndicators: false, content: {
                            //AUTO ACTIVITY
                            if(ac.count > 0){
                                Group{
                                ActivityCardGroupView(type: .AUTO , activitys: activityVM.activitys)
                                .padding(.top)
                                }
                                    
                            }
                            //Divider()
                            //AUTO
                            if(ac.count > 0){
                            ActivityCardGroupView(type: .MANUAL , activitys: ac2)
                                
                                .padding(.top)
                            }
                            
                        })
                        
                        
                    }//: VSTACK
                    .background(Color("").ignoresSafeArea(.all,edges: .all))
                    
                
                }//: ZSTACK
            .ignoresSafeArea(.all , edges: .top)
        }//: NAVIGITION
        
        }
       
}
   // MARK: -<#PREVIEW#>
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.light)
    }
}
