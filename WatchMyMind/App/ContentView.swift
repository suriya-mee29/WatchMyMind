//
//  ContentView.swift
//  WatchMyMind
//
//  Created by Suriya on 27/1/2564 BE.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @State var isAuthen : Bool = false
    @State private var username : String = ""
    @State private var password : String = ""
    // MARK: - BODY
    var body: some View {
        if isAuthen {
            HomeView()
        }else{
            VStack {
                Text("watch my mind".uppercased())
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(Color("wmm"))
                Image("watchmymind")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 220, alignment: .center)
                    .padding(.bottom,45)
                
                    //USERNAME
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                    Image(systemName: "person")
                        .font(.system(size: 24))
                        .foregroundColor(Color.white)
                        .frame(width: 60, height: 60)
                        .background(Color("wmm"))
                        .clipShape(Circle())
                    
                    TextField(L10n.Placeholder.userName.uppercased(), text: $username)
                        .padding(.horizontal)
                        .padding(.leading,65)
                        .frame(height:60)
                        .background(Color("background").opacity(0.2))
                        .clipShape(Capsule())
                    
                    
                })  //: ZSTACK
                .padding(.horizontal)
                
                //PASSWORD
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                    Image(systemName: "lock")
                        .font(.system(size: 24))
                        .foregroundColor(Color.white)
                        .frame(width: 60, height: 60)
                        .background(Color("wmm"))
                        .clipShape(Circle())
                    
                    SecureField( L10n.Placeholder.palssword.uppercased(), text: $password)
                        .padding(.horizontal)
                        .padding(.leading,65)
                        .frame(height:60)
                        .background(Color("background").opacity(0.2))
                        .clipShape(Capsule())
                    
                    
                })  //: ZSTACK
                .padding(.horizontal)
                
                Button(action: {
                    if self.password != "" && self.username != "" {
                        self.isAuthen = true
                    }
                }, label: {
                    Text(L10n.Placeholder.login.uppercased())
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color("wmm"))
                        .clipShape(Capsule())
                })
                .padding(.top , 20)
                
                
            }
        }
            
    }
}

// MARK: -PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
