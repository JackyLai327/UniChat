//
//  SettingsView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView(){
            VStack(spacing: 0) {
                HeadingView(title: "Settings")
                listOfSettingsOptions
            }
        }
        .scrollContentBackground(.hidden)
    }
    
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
