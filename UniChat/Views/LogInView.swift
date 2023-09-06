//
//  LogInView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/25.
//

import SwiftUI

struct LogInView: View {
    @State var username: String = ""
    @State var password: String = ""
        
        var body: some View {
            NavigationView {
                VStack {
                    
                    Spacer()

                    VStack {
                        Text("Log in to join")
                        Text("the convos !")
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

                    Button("Log in") {
                        print("Loggin in")
                    }
                    .font(.title2.bold())
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .background(UniChatColor.brightYellow)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding(.vertical, 40)

                    NavigationLink (destination: SignUpView()) {
                        VStack {
                            Text("Haven't got an account?")
                            Text("Sign up Here")
                        }
                        .underline()
                        .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 10)

                    Image("logo")
                        .padding(.vertical, 40)
                }
                .padding()
                .background(UniChatColor.headerYellow)
            }
            
        }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
