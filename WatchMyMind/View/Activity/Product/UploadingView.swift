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
    @State var link : String = ""
    let activity : ManualActivitiesModel
    @State var isPicked : Bool = false
    @State var sourseType : UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
    @State var isPhoto : Bool = false
    @State var isLink : Bool = false
    
    @State var results : [String:Any]
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
                            imagePicker(image: self.$image , showImagePicker: self.$isShowImagePicker, sourceType: self.sourseType)
                           
                            
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
                            //storg data to DB
                            //ending
                                NotificationCenter.default.post(name: Notification.Name("popToRootView"), object: nil)
                            //eof - ending
                            
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
                Spacer()
            }
           
        }//ZSTACK
    
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
        UploadingView(activity: ManualActivitiesModel(createdby: "", description: "", imageIcon: "", title: "", type: "", everyDay: false, time: 0, round: 0, activityPath: ""), results: [String : Any]())
    }
}
