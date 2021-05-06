//
//  sourcesPicker.swift
//  WatchMyMind
//
//  Created by Suriya on 18/2/2564 BE.
//

import Foundation
import SwiftUI

struct imagePicker:UIViewControllerRepresentable{
    @Binding var image : UIImage?
    @Binding var showImagePicker: Bool
    @Binding var imageURL : URL?
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = imagePickerCoordinator
    var sourceType:UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<imagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func makeCoordinator() -> imagePicker.Coordinator {
        return imagePickerCoordinator(image: $image, showImagePicker: $showImagePicker, imageURL: $imageURL)
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<imagePicker>) {
        
    }
    
    
}
class imagePickerCoordinator : NSObject , UINavigationControllerDelegate , UIImagePickerControllerDelegate {
    @Binding var image : UIImage?
    @Binding var showImagePicker: Bool
    @Binding var imageURL : URL?
    
    init(image:Binding<UIImage?> , showImagePicker : Binding <Bool>,imageURL :Binding<URL?> ){
        _image = image
        _showImagePicker = showImagePicker
        _imageURL = imageURL
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let uiimage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = uiimage
            let imageName = UUID().uuidString
            let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

              if let jpegData = uiimage.jpegData(compressionQuality: 0.8) {
                  try? jpegData.write(to: imagePath)
              }
            self.imageURL = imagePath
            showImagePicker = false
        }
       
       

      
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        showImagePicker = false
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
