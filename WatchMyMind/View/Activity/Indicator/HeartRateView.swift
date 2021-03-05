//
//  HeartRateView.swift
//  WatchMyMind
//
//  Created by Suriya on 15/2/2564 BE.
//

import SwiftUI

enum Mode : String{
    case START = "start"
    case STOP = "stop"
}


struct HeartRateView: View {
    // MARK: - PROPERTIES
    @State private var isAnimated : Bool = false
    @State private var isStart : Bool = false
    @State private var color : Color = Color.green
    @State private var BTNmsg : Mode = Mode.START
    @State private var isDone : Bool = false
    
    @ObservedObject var stopwatch = Stopwatch()
   

    
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                NavigationBarViewII(title: "watchmymind", imageIconRight: "")
                    .padding(.horizontal , 15)
                    .padding(.bottom)
                    .padding(.top ,
                             UIApplication.shared.windows.first?.safeAreaInsets.top)
               
                ZStack (alignment: .top){
                    ZStack {
                        Image(systemName: "suit.heart.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.accentColor)
                            .frame(width: 300, height: 300)
                            .scaleEffect( isAnimated  ? 1.0 : 0.7 )
                            .padding(30)
                    }
                    .background(Color("bw"))
                    .clipShape(Circle())
                    .zIndex(1.0)
                    
                    VStack{
                       
                        Text(stopwatch.message)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width : UIScreen.main.bounds.width)
                            .padding(.top,200)
                            
                        Button(action: {
                            if stopwatch.isRunning {
                                stopwatch.stop()
                            } else {
                                stopwatch.start()
                            }
                            if isStart && !isDone{
                                color = Color.green
                                BTNmsg = .START
                                
                            }else{
                                BTNmsg = .STOP
                                color = Color.red
                                isDone = true
                                // nivigate to anther view
                                
                                
                            }
                            isStart = true
                           
                        }, label: {
                            Text(BTNmsg.rawValue.uppercased())
                                .foregroundColor(.white)
                                .font(.title2)
                        })
                        .padding()
                        .background(
                            color
                                .cornerRadius(20))
                        .background(
                            RoundedRectangle(cornerRadius: 20).stroke(Color.gray,lineWidth: 1)
                        )
                        
                     
                        Spacer()
                    }
                    .background(Color("wmm"))
                    .padding(.top,200)

                    
                    
                }
                    
               
                
                
                
                
            }
            .onAppear(perform: {
                
                withAnimation(!isStart ? Animation.easeIn(duration: 0.5).repeatForever(autoreverses: false) : Animation.default){
                    isAnimated.toggle()
                           
                }
                
                
            })
        } //: ZSTACK
        .ignoresSafeArea(.all,edges: .all)
    }
}
// MARK: -PREVIEW
struct HeartRateView_Previews: PreviewProvider {
    static var previews: some View {
        HeartRateView()
            .preferredColorScheme(.light)
            
    }
}
