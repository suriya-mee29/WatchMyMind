//
//  WatingView.swift
//  WatchMyMind
//
//  Created by Suriya on 5/4/2564 BE.
//

import SwiftUI
import BBRefreshableScrollView

struct WatingView: View {
    @Binding var status : String
    let userName : String
    let user  = User()
    
    var body: some View {
        VStack (alignment : .center) {
            BBRefreshableScrollView{ completion in
                
                user.getUserSatus(username: userName){ st in
                    status = st
                    print("com")
                    completion()
                }
               
                
            } content : {
                VStack (alignment : .center){
                    Spacer()
                    Image(systemName: "hourglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(Color("wmm"))
                        .padding(.top)
                 
                    Text("waiting".uppercased())
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.vertical)
                    
                    VStack {
                        Text("Please contact the Psychologist to confirm a new client.")
                            .font(.system(size: 16))
                            .font(.footnote)
                            .padding(.horizontal)
                            .foregroundColor(.secondary)
                        
                       
                    }
                    
                    
                    
                }
        }
        }
    }
}

struct WatingView_Previews: PreviewProvider {
    static var previews: some View {
        WatingView(status: .constant("inactive"), userName: "6009650026")
    }
}
