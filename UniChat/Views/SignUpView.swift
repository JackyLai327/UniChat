//
//  SignUpView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/25.
//

import SwiftUI

struct SignUpView: View {
    // for custom back button dismiss action
    @Environment(\.dismiss) private var dismiss
    
    // user credentials
    @State var username: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack {
                Text("Sign up to discuss")
                Text("about your dream uni !")
            }
            .font(.title2.bold())
            .foregroundColor(UniChatColor.lightBrown)
            .padding(.vertical, 50)
            
            
            VStack (spacing: 2) {
                Text("Username")
                    .font(.headline)
                    .foregroundColor(UniChatColor.lightBrown)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 40)
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(UniChatColor.brightYellow, lineWidth: 3)
                        .background(.white)
                        .frame(maxHeight: 35)
                    TextField("Username", text: $username)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                }
                .padding(.horizontal, 40)
            }
            
            VStack (spacing: 2) {
                Text("Password")
                    .font(.headline)
                    .foregroundColor(UniChatColor.lightBrown)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 40)
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(UniChatColor.brightYellow, lineWidth: 3)
                        .background(.white)
                        .frame(maxHeight: 35)
                    TextField("Password", text: $password)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                }
                .padding(.horizontal, 40)
            }
            .padding(.top, 20)
            
            VStack (spacing: 2) {
                Text("Confirm Password")
                    .font(.headline)
                    .foregroundColor(UniChatColor.lightBrown)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 40)
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(UniChatColor.brightYellow, lineWidth: 3)
                        .background(.white)
                        .frame(maxHeight: 35)
                    TextField("Confirm Password", text: $password)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                }
                .padding(.horizontal, 40)
            }
            .padding(.top, 20)
            
            Button("Sign up") {
                print("Signing up")
            }
            .font(.title2.bold())
            .padding(.horizontal, 40)
            .padding(.vertical, 15)
            .background(UniChatColor.brightYellow)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding(.vertical, 40)
            
            Image("logo")
                .padding(.vertical, 40)
        }
        .padding()
        .background(UniChatColor.headerYellow)
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        customBackButton
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(UniChatColor.brightYellow)
                    }
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Disussion")
                    .font(.title.bold())
                    .background(UniChatColor.headerYellow)
                    .foregroundColor(UniChatColor.brown)
            }
        }
    }
    
    var customBackButton: some View {
        Image(systemName: "chevron.left")
            .font(.title.bold())
            .foregroundColor(UniChatColor.brightYellow)
    }
}
    
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

