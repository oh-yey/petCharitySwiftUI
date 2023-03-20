//
//  ImagePicker.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/19.
//
import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    
    var sourceType: UIImagePickerController.SourceType
    
    let onSubmit: ((UIImage) -> Void)
    
    init(sourceType: UIImagePickerController.SourceType = .camera, onSubmit: @escaping ((UIImage) -> Void)) {
        self.sourceType = sourceType
        self.onSubmit = onSubmit
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let parent: ImagePicker
        let onSubmit: ((UIImage) -> Void)
        
        init(_ parent: ImagePicker, onSubmit: @escaping ((UIImage) -> Void)) {
            self.parent = parent
            self.onSubmit = onSubmit
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                onSubmit(image)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, onSubmit: onSubmit)
    }
}
