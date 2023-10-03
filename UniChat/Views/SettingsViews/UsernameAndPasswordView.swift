//
//  UsernameAndPasswordView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/22.
//

import SwiftUI

struct UsernameAndPasswordView: View {
    // for dismiss action
    @Environment(\.dismiss) private var dismiss
    
    // user defuaults for displaying
    let defaults = UserDefaults.standard
    
    // display password
    @State var showPassword = false
    
    var body: some View {
        VStack (spacing: 0) {
            HeadingView(title: "")
            ScrollView {
                VStack {
                    HStack {
                        Text("Username:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(defaults.string(forKey: "currentUsername") ?? "username unknown")")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .font(.headline)
                    .foregroundColor(UniChatColor.brown)
                    .padding()
                    .background(UniChatColor.white)
                    .cornerRadius(25)
                    
                    HStack {
                        Text("Password:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        if showPassword {
                            Text("\(defaults.string(forKey: "currentPassword") ?? "password unknown")")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        } else {
                            Text("show password")
                        }
                    }
                    .onTapGesture {
                        showPassword = !showPassword
                    }
                    .font(.headline)
                    .foregroundColor(UniChatColor.brown)
                    .padding()
                    .background(UniChatColor.white)
                    .cornerRadius(25)
                }
                .padding(20)
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
                Text("Username and Password")
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

struct UsernameAndPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameAndPasswordView()
    }
}
