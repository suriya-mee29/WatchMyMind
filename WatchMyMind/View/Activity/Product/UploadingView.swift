//
//  UploadingView.swift
//  WatchMyMind
//
//  Created by Suriya on 29/4/2564 BE.
//

import SwiftUI

struct UploadingView: View {
    // MARK: - PROPERTIES
    @State private var isShowImagePicker : Bool = false
    @State var image : UIImage?
    @State var imageURL : URL?
    @State var link : String = ""
    let activity : ManualActivitiesModel
    @State var isPicked : Bool = false
    @State var sourseType : UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
    @State var isPhoto : Bool = false
    @State var isLink : Bool = false
    
    
    @ObservedObject var activityStorage = ActivityStorage()
    
    
    @State var showAlert : Bool = false
    @State var alertMessage : String = ""
    @State var headerMag : String = ""
    
    @State var results : [String:Any]
    @State var isSubmit : Bool = false
    
    
    
    // MARK: - function
    private func save (path: String , results : [String: Any]){
        activityStorage.saveResults(path: path, results: results) { seccess , msg in
            
            if seccess {
            NotificationCenter.default.post(name: Notification.Name("popToRootView"), object: nil)
            }else{
                self.headerMag = "error"
                self.alertMessage = "error from database: \(msg) "
                self.showAlert = true
            }
        }
    }
    var body: some View {
        ZStack {
            VStack {
                
                ScrollView {
                    //upload pic
                    if isPhoto {
                    Text("อัพโหลดรูปภาพที่วาด")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top)
                        .lineLimit(2)
                    if image == nil {
                        Image(systemName: "square.and.arrow.up")
                             .resizable()
                             .scaledToFit()
                             .frame(width: UIScreen.main.bounds.width * 0.38, height: UIScreen.main.bounds.width * 0.38)
                             .foregroundColor(.accentColor)
                             .padding()
                             .padding(.top, UIScreen.main.bounds.height * 0.02)
                    } else {
                        Image(uiImage: image!)
                             .resizable()
                             .scaledToFit()
                             
                             .foregroundColor(.accentColor)
                             .padding()
                             .padding(.top, UIScreen.main.bounds.height * 0.02)
                    }
                    HStack{
                        Button(action: {
                            isShowImagePicker = true
                           
                        }, label: {
                            Text("Pick one".uppercased())
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding()
                        }).sheet(isPresented: $isShowImagePicker){
                            imagePicker(image: self.$image , showImagePicker: self.$isShowImagePicker, imageURL: self.$imageURL, sourceType: self.sourseType)
                           
                            
                        }
                        .background(Color("wmm"))
                        .clipShape(Capsule())
                      
                      }
                    }
                    //eof-upload pic
                        
                    
                
                //uploadlink
                    if isLink {
                    Text("อัพโหลดลิงค์ของหนังที่ดูหรือTrailerของหนัง")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top)
                        .lineLimit(2)
                    
                    Image(systemName: "square.and.arrow.up")
                         .resizable()
                         .scaledToFit()
                         .frame(width: UIScreen.main.bounds.width * 0.38, height: UIScreen.main.bounds.width * 0.38)
                         .foregroundColor(.accentColor)
                         .padding()
                         .padding(.top, UIScreen.main.bounds.height * 0.02)
                    
                    LinkFieldView(link: $link)
                    .padding(.horizontal)
                    .padding(.top)
                    }
                    // eof-uploadlink
                  
                    
                    HStack{
                        Button(action: {
                            if !isSubmit{
                                self.isSubmit = true
                            //storg data to DB
                            //ending
                            if isLink{
                                if self.link != ""{
                                self.results["link"] = self.link
                                }else{
                                    self.headerMag = "Invalide"
                                    self.alertMessage = "Please attach link your link before submission"
                                    self.showAlert = true
                                }
                            }
                            
                            
                            if isPhoto {
                                    let id = UUID().uuidString
                                    if let url = self.imageURL{
                                        activityStorage.uploadImage(url, filename: id) { seccess, message in
                                            
                                            if seccess , let msg = message{
                                                self.results["photoURL"] = msg
                                                
                                                self.save(path: self.activity.activityPath, results: self.results)
                                                
                                            }else{
                                                self.headerMag = "error"
                                                self.alertMessage = "error from database: \(message ?? "error") "
                                                self.showAlert = true
                                            }
                                        }
                                        

                                    }else{
                                        self.headerMag = "error"
                                        self.alertMessage = "path file error "
                                        self.showAlert = true
                                    }
                                
                                
                                
                            }else{
                                self.save(path: self.activity.activityPath, results: self.results)
                            }
                            
                           
                                
                            //eof - ending
                            }
                            
                        }, label: {
                            Text("submit".uppercased())
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding()
                        })
                   }
                        .background(Color("wmm"))
                        .clipShape(Capsule())
                        .padding()
                }
                
                if isSubmit{
                    if isPhoto{
                    HStack {
                        ProgressView("\(self.activityStorage.percentComplete == 100 ? "Uploding your date, almost done...":"Uploading your picture")",value:self.activityStorage.percentComplete , total:99)
                    }
                    }else{
                        HStack {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .secondary))
                                .scaleEffect(1)
                            Text(" Uploding your date, almost done...")
                                .font(.footnote)
                                .fontWeight(.bold)
                        }
                    }
                    
                }
                Spacer()
            }
           
        }//ZSTACK
        .alert(isPresented: $showAlert , content: {
            Alert(title: Text(self.headerMag.uppercased()), message: Text("\(self.alertMessage)"), dismissButton: .default(Text("OK!")))
                    }
        )
    
        .onAppear(perform: {
            if activity.outcomeReq.count > 0{
            for i in 0...(activity.outcomeReq.count - 1){
                if activity.outcomeReq[i] == "reqLink"{
                    self.isLink = true
                }
                if activity.outcomeReq[i] == "reqPhoto"{
                    self.isPhoto = true
                }
            }
            
            }
          
            
            
        })
    }
}

struct UploadingView_Previews: PreviewProvider {
    static var previews: some View {
        UploadingView(activity: ManualActivitiesModel(createdby: "", description: "", imageIcon: "", title: "", type: "", everyDay: false, time: 0, round: 0, activityPath: "", observedPath: "",startDate: Date(),endDate:Date()), results: [String : Any]())
    }
}
