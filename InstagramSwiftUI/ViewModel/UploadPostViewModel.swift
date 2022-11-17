//
//  UploadPostViewModel.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 16/11/2022.
//

import _PhotosUI_SwiftUI

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
}
