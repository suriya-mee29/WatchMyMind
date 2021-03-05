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
    var breating : String
    var date : Date
    // MARK: - BODY
    var body: some View {
       
        ZStack {
            HStack (alignment: .top){
                    
                    ZStack {
                        Image(systemName: "lungs")
                            .padding()
                            .foregroundColor(.accentColor)
                            .font(.largeTitle)
                           
                    }
                    .background(Color("wmm").opacity(0.5))
                    .clipShape(Circle())
                    
                    VStack (alignment:.leading){
                        Text(title.uppercased())
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(.accentColor)
                        Text("\(breating) sec.")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                        
                    }.padding(.top)
                Spacer()
                    
                    Text("\(date , formatter: taskDateFormat)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        
                   
                    
                }//: VSTACK
                .padding()
            
            .frame(width: UIScreen.main.bounds.width * 0.9)
        }
           
        .background(
                        Color.gray.opacity(0.2)
                            .cornerRadius(25)
                )
    }
}
// MARK: -PREVIEW
struct BioDataCardIView_Previews: PreviewProvider {
    static var previews: some View {
        BioDataCardIView(title: "BREATHING", breating: "5", date:Date())
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
