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
    @State var action : Int? = 0
    @State var results : [String:Any]
    
    let activity : ManualActivitiesModel
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
                ScrollView(.vertical, showsIndicators: false, content: {
                    NavigationLink(
                        destination: Text("Ending View"),
                        tag: 200,
                        selection: $action,
                        label: {EmptyView()})
                    
                    NavigationLink(
                        destination: UploadingView(activity: self.activity, results: self.results),
                        tag: NavigationTag.UPLOADING.rawValue,
                        selection: $action,
                        label: {EmptyView()})
                })
                .frame(height : 0)
                Button(action: {
                    print("btn")
                    print("outcome-->\(activity.outcomeReq.count)")
              
                    if activity.outcomeReq.count != 0 {
                        action = NavigationTag.UPLOADING.rawValue
                        
                    }else{
                        //end
                         action = 200
                    }
                   
                }, label: {
                    Text("next")
                })
                .padding()
            }
                
        }//: ZSTACK
        .ignoresSafeArea(.all,edges: .all)
        .onAppear(perform: {
            action = 0
        })
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
        NotingView(results: [String : Any](), activity:  ManualActivitiesModel(createdby: "", description: "", imageIcon: "", title: "", type: "", everyDay: false, time: 0, round: 0, activityPath: ""))
    }
}
