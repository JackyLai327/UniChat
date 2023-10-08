//
//  VerificationCameraView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/10/6.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct VerificationCameraView: View {
    // for dismiss action
    @Environment(\.dismiss) private var dismiss
    
    // for picking images for verification
    @State var selectedImageItem: PhotosPickerItem?
    @State var selectedImage: Image?
    @State var selectedImageDataString: String?
    
    // submitted state
    @State var submitted = false
    
    // MARK: verification process requires sending data to server but there's no server for this prototype
    var body: some View {
        VStack (spacing: 0) {
            HeadingView(title: "")
            
            ScrollView {
                
                VStack {
                    if let selectedImage {
                        VStack {
                            selectedImage
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                                .padding(.bottom, -10)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .onChange(of: selectedImageItem) { _ in
                    Task {
                        if let data = try? await selectedImageItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                selectedImage = Image(uiImage: uiImage)
                                selectedImageDataString = uiImage.pngData()?.base64EncodedString()
                                return
                            }
                        }
                        
                        print("Failed")
                    }
                }
                
                if !submitted {
                    // selecting an image from photo library
                    PhotosPicker(selection: $selectedImageItem, matching: .images) {
                        HStack {
                            Image(systemName: "photo.on.rectangle.angled")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                .foregroundColor(UniChatColor.brightYellow)
                                .padding(20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Select a proof of enrolment to upload")
                                .font(.headline)
                                .foregroundColor(UniChatColor.brown)
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding()
                    .background(UniChatColor.white)
                    .cornerRadius(25)
                    .padding()
                    
                    // taking a photo
                    // MARK: Taking a photo is not available without Apple Developer Account
                    NavigationLink(destination: CameraView()) {
                        HStack {
                            Image(systemName: "camera.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                .foregroundColor(UniChatColor.brightYellow)
                                .padding(20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Take a photo")
                                .font(.headline)
                                .foregroundColor(UniChatColor.brown)
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding()
                    .background(UniChatColor.white)
                    .cornerRadius(25)
                    .padding()
                    
                    if let selectedImage {
                        Button("submit") {
                            submitted = true
                        }
                        .padding()
                        .background(UniChatColor.headerYellow)
                        .cornerRadius(25)
                        .foregroundColor(UniChatColor.brown)
                    }
                } else {
                    VStack {
                        Image(systemName: "hand.thumbsup.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .foregroundColor(UniChatColor.brightYellow)
                            .padding(.vertical)
                        Text("submitted!")
                            .padding(.bottom)
                        Text("we will come back with your results in a few days")
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(UniChatColor.brown)
                }
                
            }
            .background(UniChatColor.dimmedYellow)
        }
        // custom navigation back button
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    customBackButton
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Verification")
                    .font(.title2.bold())
                    .background(UniChatColor.headerYellow)
                    .foregroundColor(UniChatColor.brown)
            }
            
        }
    }
    
    // customised back button for application
    var customBackButton: some View {
        Image(systemName: "chevron.left")
            .font(.title.bold())
            .foregroundColor(UniChatColor.brightYellow)
    }
}

struct VerificationCameraView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationCameraView()
    }
}
