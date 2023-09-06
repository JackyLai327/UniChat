//
//  WritePostView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/22.
//

import SwiftUI

struct WritePostView: View {
    
    // get context to write to coredata
    @Environment(\.managedObjectContext) var context
    
    // state variable for content when user's editing
    @State private var content = ""
    
    // state variable for selecting a target
    @State private var target = ""
    
    // temporary list of unis
    var listOfUni = ["RMIT University", "Melbourne University"]
    
    // temporary logged in user
    var user = "uniChat"
    
    var characterLimit = 500
    
    @State var showContentLengthAlert = false
    @State var showNoTargetAlert = false
    
    
    var body: some View {
        VStack {
            HeadingView(title: "Start a Discussion")
            Picker("select a uni / lecturer to write about ...", selection: $target) {
                Text("select a uni / lecturer to write about ...").tag("")
                ForEach(listOfUni, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.menu)
            .accentColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView {
                HStack {
                    Text(user)
                        .foregroundColor(UniChatColor.brown)
                    Spacer()
                    Text("\(content.count) / \(characterLimit)")
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
                
                TextField("don't be shy , what's on your mind ...", text: $content,
                          axis: .vertical)
                
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .foregroundColor(UniChatColor.brightYellow)
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Button {
                    if target != "" && target != listOfUni[0] && content.count <= characterLimit {
                        // if no problem create a discussion
                        createDiscussion(content: content, target: target, user: user)
                        // reset the content and target
                        content = ""
                        target = ""
                    } else if target == listOfUni[0] || content.count >= characterLimit {
                        showContentLengthAlert = true
                    } else if target == "" {
                        showNoTargetAlert = true
                    }
                    
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .foregroundColor(UniChatColor.brightYellow)
                        .padding(30)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .alert(isPresented: $showContentLengthAlert) {
                    contentLengthAlert as! Alert
                }
                .alert(isPresented: $showNoTargetAlert) {
                    noTargetSelectedAlert as! Alert
                }
            }
        }
    }
    
    func createDiscussion(content: String, target: String, user: String) {
        let discussion = Discussion(context: context)
        discussion.id = UUID()
        discussion.content = content
        discussion.numLikes = 0
        discussion.numReplies = 0
        discussion.numShares = 0
        discussion.target = target
        discussion.timestamp = Date()
        discussion.username = user
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    var contentLengthAlert: Any {
        Alert(
            title: Text("Sorry Mate"),
            message: Text("the length of content must be between 0 to 500 characters . "),
            dismissButton: .default(
                Text("Alright")
            )
        )
    }
    
    var noTargetSelectedAlert: Any {
        Alert(
            title: Text("Sorry Mate"),
            message: Text("please choose a uni / lecturer to write about before you start a discussion . "),
            dismissButton: .default(
                Text("Alright")
            )
        )
    }
}

struct WritePostView_Previews: PreviewProvider {
    static var previews: some View {
        WritePostView()
    }
}
