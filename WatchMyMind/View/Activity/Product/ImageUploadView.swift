//
//  UploadView.swift
//  WatchMyMind
//
//  Created by Suriya on 18/2/2564 BE.
//

import SwiftUI

struct ImageUploadView: View {
    // MARK: - PROPERTIES
    @State private var isShowImagePicker : Bool = false
    @State  var image : UIImage?
    @State var sourseType : UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
    
    @State var isPicked : Bool = false
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                NavigationBarViewII(title: "watchmymind", imageIconRight: "")
                    .padding(.horizontal , 15)
                    .padding(.bottom)
                    .padding(.top ,
                             UIApplication.shared.windows.first?.safeAreaInsets.top)
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
                    if image != nil{
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("submit".uppercased())
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding()
                        })
                        .background(Color("wmm"))
                        .clipShape(Capsule())
                        
                    }
                }
                
               
                Spacer()
                
            }
        }//: ZSTACK
        .ignoresSafeArea(.all,edges: .all)
    }
}
// MARK: -PREVIEW
struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUploadView()
            .preferredColorScheme(.light)
    }
}
