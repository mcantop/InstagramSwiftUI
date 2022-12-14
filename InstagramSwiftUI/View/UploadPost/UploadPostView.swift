//
//  UploadPostView.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    @Binding var selectedIndex: Int
    @ObservedObject var viewModel = UploadPostViewModel()
    @State private var showingAlert = false
    
    var body: some View {
        VStack(spacing: 16) {
            PhotosPicker(selection: $viewModel.selectedItem, matching: .images, photoLibrary: .shared()) {
                if let selectedImageData = viewModel.selectedImageData,
                   let uiImage = UIImage(data: selectedImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    ZStack {
                        Image(systemName: "photo")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .overlay(RoundedRectangle(cornerRadius: 10))
                            .padding(5)
                            .frame(maxWidth: .infinity, maxHeight: 180)
                            .foregroundStyle(Color("TextColor"))
                        
                        Image(systemName: "photo.fill")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 180)
                            .foregroundStyle(Color("BackgroundColor"))

                    }
                }
            }
            .buttonStyle(.plain)

            .onChange(of: viewModel.selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        withAnimation {
                            viewModel.selectedImageData = data
                        }
                    }
                }
            }
            
            TextField("Enter your caption...", text: $viewModel.captionText, axis: .vertical)
                .lineLimit(10)
            
            Spacer()
            
            Button {
                if let selectedImageData = viewModel.selectedImageData,
                   let uiImage = UIImage(data: selectedImageData) {
                    viewModel.uploadPost(caption: viewModel.captionText, image: uiImage) {
                        showingAlert.toggle()
                    }
                }
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
                viewModel.showingAlert.toggle()
            } label: {
                Text("Remove Draft")
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundColor(Color("TextColor"))
                    .fontWeight(.semibold)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.gray, lineWidth: 1))
            }
            .alert("Remove Draft", isPresented: $viewModel.showingAlert) {
                Button(role: .destructive) {
                    withAnimation {
                        viewModel.removeDraft()
                    }
                } label: {
                    Text("Remove")
                }
                
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Are you sure you want to remove your draft?")
            }
        }
        .padding()
        .alert("Success!", isPresented: $showingAlert) {
            Button("Awesome!") {
                withAnimation(.easeInOut) {
                    viewModel.removeDraft()
                    selectedIndex = 0
                }
            }
        } message: {
            Text("Uploaded new post successfully! Hooray ????")
        }
    }
}

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView(selectedIndex: .constant(0))
    }
}
