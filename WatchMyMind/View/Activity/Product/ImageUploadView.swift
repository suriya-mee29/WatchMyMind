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
    @Binding  var image : UIImage?
    @State var sourseType : UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
    
    @State var isPicked : Bool = false

    // MARK: - BODY
    var body: some View {
      
            VStack {
              
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
      
       
    }
}
// MARK: -PREVIEW
struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUploadView(image: .constant(UIImage()))
            .preferredColorScheme(.light)
    }
}
