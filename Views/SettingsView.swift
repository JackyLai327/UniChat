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
            List(){
                NavigationLink("my discussions", destination: MyDiscussionsView())
                NavigationLink("username and password", destination: UsernameAndPasswordView())
                NavigationLink("verification", destination: VerificationView())
                NavigationLink("push notifications", destination: PushNotificationsView())
                NavigationLink("report a problem", destination: ReportAProblemView())
            }.background(UniChatColor.dimmedYellow)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Settings")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                        .foregroundColor(UniChatColor.brown)
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
