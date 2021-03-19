//
//  BioDataCardIView.swift
//  WatchMyMind
//
//  Created by Suriya on 11/2/2564 BE.
//

import SwiftUI

struct BioDataCardIView: View {
    // MARK: - PROPERTIES
    let title : String
    let imageIcon : String
    var value : String
    var date : Date
    // MARK: - BODY
    var body: some View {
       
        ZStack {
            VStack {
                //Date and Time
                HStack(alignment: .bottom){
                    Spacer()
                    Image(systemName: "calendar.circle.fill")
                        .font(.footnote)
                    .foregroundColor(.gray)
                    Text("\(date , formatter: taskDateFormat)")
                            .font(.footnote)
                        .foregroundColor(.gray)
                    Image(systemName: "clock.fill")
                        .font(.footnote)
                    .foregroundColor(.gray)
                    Text("\(date,formatter: dateFormatter)")
                        .font(.footnote)
                    .foregroundColor(.gray)
                }
              
                
                HStack(alignment:.top){
                    ZStack {
                        Image(imageIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                            //.foregroundColor(.accentColor)
                    
                           
                    }
                    .background(Color("wmm").opacity(0.5))
                    .clipShape(Circle())
                    
                    VStack (alignment:.leading){
                        Text(title.uppercased())
                            .font(.system(size: 15))
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(.accentColor)
                        Text("\(value) ")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                        
                    }.padding(.top)
                    Spacer()
                  
                }
                .padding(.top,-8)
            
            }// EO - VSTACK
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.9)
        
            
         
        }
           
        .background(
                        Color.gray.opacity(0.2)
                            .cornerRadius(25)
                )
    }//View
}
// MARK: -PREVIEW
struct BioDataCardIView_Previews: PreviewProvider {
    static var previews: some View {
        BioDataCardIView(title: "BREATHIN", imageIcon: "highIntensityIntervalTraining", value: "5 somthing", date:Date())
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
