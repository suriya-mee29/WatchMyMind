//
//  DescriptionView.swift
//  WatchMyMind
//
//  Created by Suriya on 3/2/2564 BE.
//

import SwiftUI

struct DescriptionView: View {
    // MARK: - PROPERTIES
    @State private var isAnnimatingImage : Bool = false
    let imageIcon : String
    let title : String
    let description : String
    let navigationTag : NavigationTag
    
    @Environment(\.managedObjectContext) private var viewContext
    @State  var action: Int? = 0
    @State var isDate : Bool = false
    // MARK: - FUNCTION
    
    
    
    // MARK: - BODY
    var body: some View {
            ZStack{
                VStack {
                    NavigationBarViewII(title: "watchmymind", imageIconRight: "")
                        .padding(.horizontal , 15)
                        .padding(.bottom)
                        .padding(.top ,
                                 UIApplication.shared.windows.first?.safeAreaInsets.top)
                    Image(imageIcon)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color("wmm"))
                        .frame(width: 250, height: 250, alignment: .center)
                        .padding(.top , UIScreen.main.bounds.height * 0.05)
                        .scaleEffect(isAnnimatingImage ? 1.0 : 0.6)
                        .onAppear(){
                            withAnimation(.easeOut(duration: 0.5)){
                                isAnnimatingImage = true
                            }
                        }
                        .onDisappear(perform: {
                            isAnnimatingImage = false
                        })
                       
                    ScrollView(.vertical, showsIndicators: false, content: {
                        Text(title.uppercased())
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(Color("wmm"))
                       
                            
                            Text(description)
                                .font(.body)
                                .padding(.horizontal , UIScreen.main.bounds.width * 0.1)
                                .foregroundColor(.gray)
                                .padding(.top,5)
                        
                           Text("30 Min/Day")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(Color("stand"))
                            .padding(.top,5)
                    })
                    .padding(.bottom)
                  
                    
                    
                  Spacer()
                    NavigationLink(destination: 
                    BioDataListView(headline: "BREATHING")
                        .environment(\.managedObjectContext, viewContext)
                                   , tag: 1, selection: $action){
                        EmptyView()
                        
                    }
                    
                    
                    //START BTN
                    Button(action: {
                        self.action = navigationTag.rawValue
                    }, label: {
                        HStack{
                            Text("start".uppercased())
                                .fontWeight(.bold)
                                .padding()
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                    })
                    .background(Color("wmm"))
                    .clipShape(Capsule())
                    .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 5)
                    //: Btton
                }
               
                
            }//: ZSTACK
            .ignoresSafeArea(.all , edges: .top)
        }
    }
// MARK: -PREVIEW
struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(imageIcon: "hobby", title: "swimming", description: "Faster music can make you feel more alert and concentrate better.", navigationTag: .TO_BIODATA_VIEW)
            .preferredColorScheme(.light)
            
    }
}
