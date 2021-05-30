//
//  NotingView.swift
//  WatchMyMind
//
//  Created by Suriya on 15/2/2564 BE.
//

import SwiftUI

struct NotingView: View {
    // MARK: - PROPERTIES
    let photoString : String
    let linkString : String
    @State private var inputText : String = ""
    @State private var countText : Int = 0
    @State var action : Int? = 0
    @State var results : [String:Any]
    
    @State var showAlert : Bool = false
    @State var alertMessage : String = ""
    @State var headerMag : String = ""
    
    let activity : ManualActivitiesModel
    
    @ObservedObject var textRecognition = TextRecognition()
    @ObservedObject var activityStorage = ActivityStorage()
    @State  var showAttchedFile : Bool = false
    
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
                if self.photoString != "" || self.linkString != ""{
                    ZStack {
                        Button(action: {
                        self.showAttchedFile.toggle()
                    }, label: {
                        HStack {
                            Image(systemName: "filemenu.and.cursorarrow")
                                .font(.title3)
                            Text("activity file".uppercased())
                                .font(.title3)
                                .fontWeight(.bold)
                              
                        }
                    })
                        .padding()
                       
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 12).stroke(Color("wmm"),lineWidth: 2))
                }
              
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
                    print("in action at noting view")
                    if inputText != "" {
                        self.results["noting"] = self.inputText
                        
                        textRecognition.SSense(text: self.inputText) { ssense in
                            if let ssenseRes = ssense {
                                print("ssense is true")
                                self.results["score"] = ssenseRes.sentiment.score
                                self.results["polarity-neg"] = ssenseRes.sentiment.polarity_neg
                                self.results["polarity-pos"] = ssenseRes.sentiment.polarity_pos
                                self.results["polarity"] = ssenseRes.sentiment.polarity
                                
                                self.results["request"] = ssenseRes.intention.request
                                self.results["sentiment"] = ssenseRes.intention.sentiment
                                self.results["question"] = ssenseRes.intention.question
                                self.results["announcement"] = ssenseRes.intention.question
                            }
                            
                            //ending
                            if activity.outcomeReq.count != 0 {
                                action = NavigationTag.UPLOADING.rawValue
                            }else{//end
                                    action = 0
                                print("Results : \(self.results)")
                                activityStorage.saveResults(path: activity.activityPath, results: self.results) { seccess , msg in
                                    
                                    if seccess {
                                    NotificationCenter.default.post(name: Notification.Name("popToRootView"), object: nil)
                                    }else{
                                        self.headerMag = "error"
                                        self.alertMessage = "error from database: \(msg) "
                                        self.showAlert = true
                                    }
                                }
                           
                            }
                            //eof - ending
                            
                        }
              
                   
                        
                        
                    }else{
                        self.alertMessage = "Please write your note"
                        self.headerMag = "noting invalided"
                        self.showAlert = true
                       
                    }
                    
                    
                   
                }, label: {
                    Image(systemName: "chevron.forward")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 100)
                })
                .background(Color("wmm"))
                .clipShape(Capsule())
                .padding()
            }
                
        }//: ZSTACK
        .sheet(isPresented: self.$showAttchedFile, content: {
            AttachedFileView(photoString: self.photoString, linkString: self.linkString, isNext: false, localRoute: [], activity: ManualActivitiesModel(createdby: "", description: "", imageIcon: "", title: "", type: "", everyDay: false, time: 0, round: 0, activityPath: "", observedPath: "", startDate: Date(), endDate: Date()), results: [String : Any]())
        })
        .ignoresSafeArea(.all,edges: .all)
        .onAppear(perform: {
            action = 0
        })
        .alert(isPresented: $showAlert , content: {
            Alert(title: Text(self.headerMag.uppercased()), message: Text("\(self.alertMessage)"), dismissButton: .default(Text("OK!")))
                    }
        )
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
        NotingView(photoString: "", linkString:"https://www.youtube.com/watch?v=7bkHtMw620M", results: [String : Any](), activity:  ManualActivitiesModel(createdby: "", description: "", imageIcon: "", title: "", type: "", everyDay: false, time: 0, round: 0, activityPath: "", observedPath: "",startDate: Date(),endDate:Date()))
    }
}
