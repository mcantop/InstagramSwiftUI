//
//  ImageUploader.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 16/11/2022.
//

import UIKit
import FirebaseStorage

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.2) else { return }
        
        let filename = NSUUID().uuidString
        
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: Failed to upload image: \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { url, _ in
                guard let imageUrl = url?.absoluteString else { return }
                
                print("DEBUG: Successfully uploaded an image!")
                
                completion(imageUrl)
            }
        }
    }
}
