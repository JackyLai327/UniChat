//
//  VerificationView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/22.
//

import SwiftUI

struct VerificationView: View {
    // for dismiss action
    @Environment(\.dismiss) private var dismiss
    
    // temporary verified uni list
    let listOfUni = ["Melbourne University", "Royal Melbourne Institute of Technology"]
    
    var body: some View {
        VStack (spacing: 0) {
            HeadingView(title: "")
            ScrollView {
                Text("my unis")
                    .frame(maxWidth: .infinity)
                    .font(.title2.bold())
                    .padding(.top, 50)
                    .foregroundColor(UniChatColor.brown)
                Text("you are allowed to discuss about")
                    .font(.headline)
                    .foregroundColor(UniChatColor.brown)
                VStack {
                    ForEach(listOfUni, id: \.self) { uni in
                        Text(uni)
                        Divider()
                    }
                    NavigationLink(destination: VerificationCameraView()) {
                        Text("Get verified for another uni")
                            .font(.headline)
                            .foregroundColor(UniChatColor.brown)
                    }
                }
                .padding()
                .background(UniChatColor.white)
                .cornerRadius(20)
                .padding()
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

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView()
    }
}
