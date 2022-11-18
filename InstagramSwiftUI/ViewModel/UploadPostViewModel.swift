//
//  UploadPostViewModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 16/11/2022.
//

import _PhotosUI_SwiftUI
import Firebase

final class UploadPostViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem?
    @Published var selectedImageData: Data?
    @Published var captionText = ""
    @Published var showingAlert = false
    
    func removeDraft() {
        selectedItem = nil
        selectedImageData = nil
        captionText = ""
    }
    
    func uploadPost(caption: String, image: UIImage, completion: @escaping() -> Void) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        ImageUploader.uploadImage(image: image, type: .post) { imageUrl in
            let data = ["ownerUid": user.id ?? "",
                        "ownerImageUrl": user.profileImageUrl,
                        "ownerUsername": user.username,
                        "imageUrl": imageUrl,
                        "caption": caption,
                        "likes": 0,
                        "timestamp": Timestamp(date: Date())] as [String: Any]
            
            COLLECTION_POSTS.addDocument(data: data) { _ in
                print("DEBUG: Uploaded post!")
                completion()
            }
        }
    }
}
