//
//  HomeView.swift
//  WatchMyMind
//
//  Created by Suriya on 29/1/2564 BE.
//

import SwiftUI
import HealthKit

struct HomeView: View {
    
    // MARK: - PROPERTIES
    @ObservedObject var activityVM = ActivityViewModel()
    @State public var showDescriptionView: Bool = false
    @State var isNewTripPresented = false
    @Environment(\.managedObjectContext) private var viewContext
    
    var healthStore = HealthStore()
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                    VStack (spacing:0){
                        ZStack (alignment: .top){
                            
                           
                               
                            HeaderView()
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5 )
                                .zIndex(0)
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
                   .background(Color("bw").ignoresSafeArea(.all,edges: .all))
                    
                
                }//: ZSTACK
            .ignoresSafeArea(.all , edges: .top)
        }//: NAVIGITION
        .onAppear(perform: {
            healthStore.requestAuthorization { seccess in
                if seccess {
                    healthStore.calculateWorkout2(startDate: Date(), numberOfObserved: -3){ samples in
                       
                       
                        for sample in samples!{
                          
                            
                    }
                    print("secess")
                }
                
        }
        
            }
            
        })
       
}
}
   // MARK: -<#PREVIEW#>
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.light)
    }
}
