//
//  NotingView.swift
//  WatchMyMind
//
//  Created by Suriya on 15/2/2564 BE.
//

import SwiftUI

struct NotingView: View {
    // MARK: - PROPERTIES
    @State private var inputText : String = ""
    @State private var countText : Int = 0
    // MARK: - BODY
    var body: some View {
        ZStack (alignment: .topTrailing){
          
            VStack{
                NavigationBarViewII(title: "watchmymind", imageIconRight: "")
                    .padding(.horizontal , 15)
                    .padding(.top ,
                             UIApplication.shared.windows.first?.safeAreaInsets.top)
                Text("Note")
                    .font(.title)
                    .foregroundColor(.accentColor)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Text("Explain your feelings after compled an activity.")
                    .font(.title2)
                    .fontWeight(.regular)
                    .padding(.top)
                
                TextEditor(text: $inputText)
                    .font(.body)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.secondary, lineWidth: 1)
                            )
                    .padding(.horizontal)
                    .padding(.bottom)
                    .onTapGesture {
                        hideKeyboard()
                    }
            }
                
        }//: ZSTACK
        .ignoresSafeArea(.all,edges: .all)
    }
}
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
    // MARK: -PREVIEW
struct NotingView_Previews: PreviewProvider {
    static var previews: some View {
        NotingView()
    }
}
