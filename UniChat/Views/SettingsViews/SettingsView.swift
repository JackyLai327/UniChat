//
//  SettingsView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/22.
//

import SwiftUI

/// Displays a list of setting options.
struct SettingsView: View {
    // current colout scheme
    @Environment(\.colorScheme) var colorScheme
    
    // for custom back button dismiss action
    @Environment(\.dismiss) private var dismiss
    
    // keychain manager
    let keychain = KeychainManager()
    
    // log out state
    @State var isLoggedOut = false
    
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
        VStack {
            List(){
                NavigationLink("my discussions", destination: MyDiscussionsView())
                NavigationLink("username and password", destination: UsernameAndPasswordView())
                NavigationLink("verification", destination: VerificationView())
                            NavigationLink("push notifications", destination: PushNotificationsView())
                            NavigationLink("report a problem", destination: ReportAProblemView())
                Button{
                    let credentials = Credentials(username: UserDefaults.standard.string(forKey: "currentUsername")!, password: UserDefaults.standard.string(forKey: "currentPassword")!)
                    UserDefaults.standard.removeObject(forKey: "currentUsername")
                    UserDefaults.standard.removeObject(forKey: "currentPassword")
                    try! keychain.deleteCredentials(credential: credentials)
                    isLoggedOut = true
                } label: {
                    ZStack {
                        Text("log out")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.red)
                        NavigationLink("log out", destination: LogInView(), isActive: $isLoggedOut)
                            .hidden()
                    }
                }
            }
            
            if colorScheme == .dark {
                Image("logoBrown")
                    .padding(.vertical, 40)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Image("logo")
                    .padding(.vertical, 40)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background(UniChatColor.dimmedYellow)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
