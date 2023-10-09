//
//  PushNotificationsView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/22.
//

import SwiftUI

/// Displays Push Notification settings (under development)
struct PushNotificationsView: View {
    // for dismiss action
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack (spacing: 0) {
            HeadingView(title: "")
            ScrollView {
                Text("⚠️ 🚧 ⚠️")
                    .font(.custom("emoji", size: 30))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 300)
                Text("This feature is not available yet...")
                    .font(.headline)
                    .foregroundColor(UniChatColor.brown)
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
                Text("Push Notifications")
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

struct PushNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        PushNotificationsView()
    }
}
