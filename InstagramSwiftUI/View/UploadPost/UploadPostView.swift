//
//  UploadPostView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var captionText = ""
    @State private var showingAlert = false
    
    var body: some View {
        VStack(spacing: 16) {
            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                if let selectedImageData,
                   let uiImage = UIImage(data: selectedImageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 180)
                        .foregroundColor(.black)
                }
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        withAnimation {
                            selectedImageData = data
                        }
                    }
                }
            }
            
            if selectedImageData != nil {
                TextField("Enter your caption...", text: $captionText)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Post")
                        .fontWeight(.semibold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(10)
                }
                
                Button {
                    showingAlert.toggle()
                } label: {
                    Text("Remove Draft")
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.gray, lineWidth: 1))
                }
                .alert("Remove Draft", isPresented: $showingAlert) {
                    Button(role: .destructive) {
                        withAnimation {
                            selectedItem = nil
                            selectedImageData = nil
                            captionText = ""
                        }
                    } label: {
                        Text("Remove")
                    }
                    
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Are you sure you want to remove your draft?")
                }
            }
            
            if selectedImageData == nil {
                Spacer()
            }
        }
        .padding()
    }
}

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView()
    }
}