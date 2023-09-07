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
    
    // geting context from core data to create account
    @Environment(\.managedObjectContext) var context
    
    // read from user entity
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \User.username, ascending: true) ])
    var users: FetchedResults<User>
    
    // user credentials
    @State var username: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    // for alert
    @State var showAlert = false
    @State var fieldNotFilled = false
    @State var passwordsDoNotMatch = false
    @State var usernameExisted = false
    
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
                ForEach (users) { user in
                    if user.username == username {
                        usernameExisted = true
                    }
                }
                if username != "" && password != "" && confirmPassword == password {
                    // create account if detials are filled and passwords match
                    createUser(username: username, password: password)
                    // reset all textfields after account creation
                    username = ""
                    password = ""
                    confirmPassword = ""
                } else {
                    showAlert = true
                }
            }
            .font(.title2.bold())
            .padding(.horizontal, 40)
            .padding(.vertical, 15)
            .background(UniChatColor.brightYellow)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding(.vertical, 40)
            .alert(isPresented: $showAlert) {
                userCreationAlert as! Alert
            }
            
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
    
    func createUser(username: String, password: String) {
        let user = User(context: context)
        user.username = username
        user.password = password
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    var userCreationAlert: Any {
        Alert(
            title: Text("Sorry Mate"),
            message: Text("this legend username is already taken 😢 ..."),
            dismissButton: .default(
                Text("pick a new one")
            )
        )
    }
}
    
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

