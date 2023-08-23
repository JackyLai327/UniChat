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
                heading
                listOfSettingsOptions
            }
        }
        .scrollContentBackground(.hidden)
    }
    
    var heading: some View {
        Text("Settings")
            .font(.largeTitle.bold())
            .padding()
            .frame(maxWidth: .infinity)
            .background(UniChatColor.headerYellow)
            .foregroundColor(UniChatColor.brown)
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
