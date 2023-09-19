//
//  SettingsView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/22.
//

import SwiftUI

struct SettingsView: View {
    // for custom back button dismiss action
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            HeadingView(title: "Settings")
            listOfSettingsOptions
        }
        // custom back button
        .scrollContentBackground(.hidden)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Settings")
                    .font(.title.bold())
                    .background(UniChatColor.headerYellow)
                    .foregroundColor(UniChatColor.brown)
            }
        }
    }
    
    // all setting options 
    var listOfSettingsOptions: some View {
        List(){
            NavigationLink("my discussions", destination: MyDiscussionsView())
            NavigationLink("username and password", destination: UsernameAndPasswordView())
            NavigationLink("verification", destination: VerificationView())
            NavigationLink("push notifications", destination: PushNotificationsView())
            NavigationLink("report a problem", destination: ReportAProblemView())
        }
        .background(UniChatColor.dimmedYellow)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
