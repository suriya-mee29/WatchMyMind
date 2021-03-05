//
//  ScalingView.swift
//  WatchMyMind
//
//  Created by Suriya on 15/2/2564 BE.
//

import SwiftUI

enum Scaling : String {
    case NO_PAIN = "NO PAIN"
    case MILD_PAIN = "MILD PAIN"
    case MODERATE = "MODERATE"
    case INTENCE = "INTENCE"
    case WORST_PAIN_POSSIBLE = "WORST PAIN POSSIBLE"
}

struct ScalingView: View {
    // MARK: - PROPERTIES
    @State var selectedID : String = ""
    @State var isSelected_1 : Bool = false
    @State var isSelected_2 : Bool = false
    @State var isSelected_3 : Bool = false
    @State var isSelected_4 : Bool = false
    @State var isSelected_5 : Bool = false
    //MARK: - FUNCTION
    func selected_1(){
        self.isSelected_1 = true
        self.isSelected_2 = false
        self.isSelected_3 = false
        self.isSelected_4 = false
        self.isSelected_5 = false
        print(selectedID)
        

    }
    func selected_2(){
        self.isSelected_1 = false
        self.isSelected_2 = true
        self.isSelected_3 = false
        self.isSelected_4 = false
        self.isSelected_5 = false
        print(selectedID)
       
    }
    func selected_3(){
        self.isSelected_1 = false
        self.isSelected_2 = false
        self.isSelected_3 = true
        self.isSelected_4 = false
        self.isSelected_5 = false
        print(selectedID)
       
    }
    func selected_4(){
        self.isSelected_1 = false
        self.isSelected_2 = false
        self.isSelected_3 = false
        self.isSelected_4 = true
        self.isSelected_5 = false
        print(selectedID)
        
    }
    func selected_5(){
        self.isSelected_1 = false
        self.isSelected_2 = false
        self.isSelected_3 = false
        self.isSelected_4 = false
        self.isSelected_5 = true
        print(selectedID)
     
    }
    // MARK: - BODY
    var body: some View {
        ZStack{
            VStack(alignment: .center,spacing:UIScreen.main.bounds.height * 0.05){
            NavigationBarViewII(title: "watchmymind", imageIconRight: "arrow.right")
                .padding(.horizontal , 15)
                .padding(.bottom)
                .padding(.top ,
                         UIApplication.shared.windows.first?.safeAreaInsets.top)
                VStack {
                    Text("Feeling")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.accentColor)
                    Text("Feeling level before doing an activity")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.accentColor)
                        .padding(.bottom)
                }
                
                VStack(spacing: 40){
                    //NO PAIN
                    HStack{
                        Image( "1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text(Scaling.NO_PAIN.rawValue)
                            .font(.title2)
                            .fontWeight(.regular)
                        
                        Spacer()
                        
                        Button(action: {
                                selectedID = Scaling.NO_PAIN.rawValue
                                selected_1()
                        }, label: {
                            Image(systemName: isSelected_1 ? "largecircle.fill.circle" :"circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        })
                        
                    }//: HSTACK
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
                    
                    
                    //MILD PAIN
                    HStack{
                        Image( "2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text(Scaling.MILD_PAIN.rawValue)
                            .font(.title2)
                        Spacer()
                        
                        Button(action: {
                            selectedID = Scaling.MILD_PAIN.rawValue
                            selected_2()
                        }, label: {
                            Image(systemName:  isSelected_2 ? "largecircle.fill.circle" :"circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        })
                        
                    }//: HSTACK
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
                    
                    //MODERATE
                    HStack{
                        Image( "3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text(Scaling.MODERATE.rawValue)
                            .font(.title2)
                        Spacer()
                        
                        Button(action: {
                                selectedID = Scaling.MODERATE.rawValue
                                selected_3()
                        }, label: {
                            Image(systemName:  isSelected_3 ? "largecircle.fill.circle" :"circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        })
                        
                    }//: HSTACK
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
                    
                    //INTENCE
                    HStack{
                        Image( "4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text(Scaling.INTENCE.rawValue)
                            .font(.title2)
                        Spacer()
                        
                        Button(action: {
                                selectedID = Scaling.INTENCE.rawValue
                                selected_4()
                        }, label: {
                            Image(systemName:  isSelected_4 ? "largecircle.fill.circle" :"circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        })
                        
                    }//: HSTACK
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
                    
                    //WORST PAIN POSSIBLE
                    HStack{
                        Image( "5")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text(Scaling.WORST_PAIN_POSSIBLE.rawValue)
                            .font(.title2)
                        Spacer()
                        
                        Button(action: {
                                
                            selectedID = Scaling.WORST_PAIN_POSSIBLE.rawValue
                            selected_5()
                            
                        }, label: {
                            Image(systemName:  isSelected_5 ? "largecircle.fill.circle" :"circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        })
                        
                    }//: HSTACK
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
                    
                    
                    
                }//: VSTCAK
                .padding(.top)
               
                
            Spacer()
            }
        }
        .ignoresSafeArea(.all,edges: .all)
    }
}
// MARK: -PREVIEW
struct ScalingView_Previews: PreviewProvider {
    static var previews: some View {
        ScalingView()
            .preferredColorScheme(.light)
    }
}
