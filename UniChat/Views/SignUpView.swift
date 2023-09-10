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
    @State var passwordNotSecure = false
    
    // password regex
    let passwordRegex = try! Regex("(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).+")
    
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
                        .frame(maxHeight: 35)
                    TextField("Username", text: $username)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        .foregroundColor(UniChatColor
                            .lightBrown)
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
                        .frame(maxHeight: 35)
                    SecureField("Password", text: $password)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        .foregroundColor(UniChatColor
                            .lightBrown)
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
                        .frame(maxHeight: 35)
                    SecureField("Confirm Password", text: $confirmPassword)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        .foregroundColor(UniChatColor
                            .lightBrown)
                }
                .padding(.horizontal, 40)
            }
            .padding(.top, 20)
            
            Button("Sign up") {
                
                // check if username has been taken
                if users.first(where: {$0.username == username}) != nil {
                    usernameExisted = true
                }
                
                // check if all fields are filled in
                if username == "" || password == "" || confirmPassword == "" {
                    fieldNotFilled = true
                }
                
                // check if passwords match
                if password != confirmPassword {
                    passwordsDoNotMatch = true
                }
                
                // check if password is secure
                if (password.firstMatch(of: passwordRegex) == nil) || password.count < 8 {
                    passwordNotSecure = true
                    print("password not right")
                }
                
                // if all flags are off, create user
                if !usernameExisted && !fieldNotFilled && !passwordsDoNotMatch && !passwordNotSecure {
                    // create account if detials are filled and passwords match
                    createUser(username: username, password: password)
                    // reset all textfields after account creation
                    username = ""
                    password = ""
                    confirmPassword = ""
                // if any is not right show error
                } else {
                    showAlert = true
                }
                usernameExisted = false
                fieldNotFilled = false
                passwordNotSecure = false
                passwordsDoNotMatch = false
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
                Text("Sign Up")
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
        if usernameExisted {
            return Alert(title: Text("Sorry Mate"), message: Text("This username is already taken 😢, first come first serve!"), dismissButton: .default(Text("Pick a new one")))

        } else if passwordsDoNotMatch {
            return Alert(title: Text("Sorry Mate"), message: Text("Your passwords don't match ❌, wanna try again?"), dismissButton: .default(Text("Let's try again")))
        } else if fieldNotFilled {
            return Alert(title: Text("Sorry Mate"), message: Text("All fields must be filled out to create an account (c'mon don't be lazy 😩)."), dismissButton: .default(Text("Alright boss...")))
        } else if passwordNotSecure {
            return Alert(title: Text("Sorry Mate"), message: Text("Password must:\n💬contain at least 8 characters\n💬contain a capital letter\n💬contain a lowercase letter\n💬contain a digit"), dismissButton: .default(Text("Alright boss...")))
        } else {
            return Alert(title: Text("Sorry Mate"), message: Text("Something went wrong, please try again in a bit..."), dismissButton: .default(Text("Alright")))
        }
    }
}
    
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

