//
//  LoadingView.swift
//  WatchMyMind
//
//  Created by Suriya on 26/2/2564 BE.
//

import SwiftUI
import HealthKit
import UserNotifications

struct LoadingView: View {
    // MARK: - PROPERTIES
    
   
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var num : Int = 0
    
    @Binding var showModal: Bool
    let isActivity : Bool
    let count : Int
    let activityPath : String

   
    var decription : String
    
    // MARK: - FUNCTION
    private func updateUIFromStatistics(_ StatisticsCollection : HKStatisticsCollection){
        
        
    }
    // MARK: - BODY
    var body: some View {
        
        VStack (alignment: .center){
            Spacer()
           WatchView()
            Spacer()
          
                Text(decription)
                   
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding(.horizontal,30)
                   
            ZStack {
                Button(action: {
                    if isActivity {
                        //mindfulness
                    }else{
                        //execrise
                    }
                    showModal = false
                }, label: {
                    Text("OK")
                        .font(.headline)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                })
                .padding()
            } //ZSTACK OF BTN
            .background(Color("wmm"))
            .clipShape(Capsule())
            .padding()
           
            Spacer()
            
            
        }
        .navigationBarBackButtonHidden(true)
       
        
    }
}
// MARK: - PROPERTIES
struct LoadingView_Previews: PreviewProvider {
    @State static var showModal = true
    static var previews: some View {
        LoadingView(showModal: $showModal, isActivity: false, count: 0 , activityPath: "", decription: "Please use your Apple Watch to complete an activity by use The Breathe app")
            .preferredColorScheme(.dark)
    }
}
