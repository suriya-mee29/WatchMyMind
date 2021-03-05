//
//  HeaderView.swift
//  WatchMyMind
//
//  Created by Suriya on 31/1/2564 BE.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - PROPERTIES
    @State private var isAnimated : Bool = false
    // MARK: - <#BODY#>
    var body: some View {
        ZStack {
            VStack {
                
                Text("WatchMyMind".uppercased())
                    .font(.title3)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5 )
                    .padding(.top, UIScreen.main.bounds.height * 0.05)
                    .opacity(isAnimated ? 1 : 0)
                    .offset(x : 0 , y : isAnimated ? 0 : -25)
                    .onAppear(perform: {
                        withAnimation(Animation.easeIn(duration: 0.5)){
                            isAnimated = true
                        }
                    })
                    .onDisappear(perform: {
                        isAnimated = false
                    })
                
                Text("Suriya   Meekhunthod")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.top , UIScreen.main.bounds.height * 0.025)
                VStack (alignment: .leading ){
                    HStack{
                        Image(systemName: "arrow.right")
                            .font(.title2)
                            .foregroundColor(Color("move"))
                        
                        Text("\(L10n.Header.movement) 500 \(L10n.Header.kcal)".uppercased())
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color("move"))
                    }
                    .padding(.bottom,1)
                    HStack{
                        Image(systemName: "bed.double.fill")
                            .font(.title2)
                            .foregroundColor(Color("sleep"))
                        Text("\(L10n.Header.sleeping) 7 \(L10n.Header.hr)".uppercased())
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color("sleep"))
                    }
                    .padding(.bottom,1)
                    HStack{
                        Image(systemName: "figure.stand")
                            .font(.title2)
                            .foregroundColor(Color("stand"))
                        Text("\(L10n.Header.standing) 1 \(L10n.Header.hr)".uppercased())
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color("stand"))
                    }
                    .padding(.bottom , 1)
                    HStack{
                        Image(systemName: "figure.walk")
                            .font(.title2)
                            .foregroundColor(Color("step"))
                        Text("\(L10n.Header.steping) 500 \(L10n.Header.steps)".uppercased())
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color("step"))
                    }
                    .padding(.bottom,1)
                    
                }
                .padding(.bottom,70)
            }// VSTACK
            .background(Color("wmm"))
            .clipShape(CustomShape())
            
        }
        
        
      
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
