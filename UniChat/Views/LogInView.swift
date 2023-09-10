//
//  LogInView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/25.
//

import SwiftUI

struct LogInView: View {
    // for custom back button dismiss action
    @Environment(\.dismiss) private var dismiss
    
    // login credentials
    @State var username: String = ""
    @State var password: String = ""
    
    // geting context from core data to create account
    @Environment(\.managedObjectContext) var context
    
    // read from user entity
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \User.username, ascending: true) ])
    var users: FetchedResults<User>
    
    // show alert
    @State var fieldNotFilled = false
    @State var userNotFound = false
    @State var incorrectPassword = false
    @State var showAlert = false
        
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
                                .frame(maxHeight: 35)
                            SecureField("Password", text: $password)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 15)
                        }
                        .padding(.horizontal, 40)
                    }
                    .padding(.top, 20)
                    
                    Button("Log in") {
                        if let user = users.first(where: {$0.username == username}) {
                            if user.password != password {
                                incorrectPassword = true
                            }
                        } else {
                            userNotFound = true
                        }
                        
                        
                        if username == "" || password == "" {
                            fieldNotFilled = true
                        }
                        
                        if !fieldNotFilled && !userNotFound && !incorrectPassword {
                            // LOG IN LOGIC
                            print("logged in")
                        } else {
                            showAlert = true
                        }
                        fieldNotFilled = false
                        userNotFound = false
                        incorrectPassword = false
                    }
                    .font(.title2.bold())
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .background(UniChatColor.brightYellow)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding(.vertical, 40)
                    .alert(isPresented: $showAlert) {
                        displayAlert
                    }

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
                    Text("Log In")
                        .font(.title.bold())
                        .background(UniChatColor.headerYellow)
                        .foregroundColor(UniChatColor.brown)
                }
            }

            
        }
    var displayAlert: Alert {
        if fieldNotFilled {
            return Alert(title: Text("Sorry Mate"), message: Text("All fields need to be filled out... (there are only 2...)"), dismissButton: .default(Text("Alright...")))
        } else if userNotFound {
            return Alert(title:Text("Sorry Mate"), message: Text("We couldn't find your username in system, are you sure you're with us?"), dismissButton: .default(Text("Try again")))
        } else if incorrectPassword {
            return Alert(title:Text("Sorry Mate"), message: Text("You've entered incorrect password, did you want to try again?"), dismissButton: .default(Text("Try again")))
        } else {
            return Alert(title: Text("Sorry Mate"), message: Text("Something went wrong, please try again in a bit..."), dismissButton: .default(Text("Alright")))
        }
    }
    
    var customBackButton: some View {
        Image(systemName: "chevron.left")
            .font(.title.bold())
            .foregroundColor(UniChatColor.brightYellow)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
