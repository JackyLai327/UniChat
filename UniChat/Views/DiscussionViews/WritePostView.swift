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
    @State private var targetType = ""
    
    // temporary list of unis
    var listOfUni = ["RMIT University", "Melbourne University"]
    
    // temporary list of lecturers
    var listOfLecturer = ["Shekhar Kalra"]
    
    // temporary logged in user
    var user = "uniChat"
    
    // maximum allowed number of characters in discussion content
    var characterLimit = 500
    
    // alert will be shown when true
    @State var showAlert = false
    
    
    var body: some View {
        VStack(spacing:0) {
            HeadingView(title: "Start a Discussion")
            // select uni or lecturer
            Picker("select a uni / lecturer to write about ...", selection: $target) {
                Section(header: Text("select a uni to write about ...")) {
                    ForEach(listOfUni, id: \.self) {
                        Text($0)
                    }
                }
                Section(header: Text("select a lecturer to write about ...")) {
                    ForEach(listOfLecturer, id: \.self) {
                        Text($0)
                    }
                }
            }
            .pickerStyle(.menu)
            .accentColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 10)
            
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
            
            HStack {
                Button {
                    // TODO: add this functionality for uplaoding images
                } label: {
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .foregroundColor(UniChatColor.brightYellow)
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                // upload discussion button
                Button {
                    // determine the target type first
                    if listOfUni.contains(target) {
                        targetType = "uni"
                    } else if listOfLecturer.contains(target) {
                        targetType = "lecturer"
                    }
                    
                    if target != "" && targetType != "" && content.count <= characterLimit {
                        // if no problem create a discussion
                        createDiscussion(content: content, target: target, user: user, targetType: targetType)
                        // reset the content and target
                        content = ""
                        target = ""
                    } else {
                        showAlert = true
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
                .alert(isPresented: $showAlert) {
                    discussionCreationAlert as! Alert
                }
            }
        }
        .background(UniChatColor.dimmedYellow)
    }
    
    // create a new Discussion object and store it in core data
    func createDiscussion(content: String, target: String, user: String, targetType: String) {
        let discussion = Discussion(context: context)
        discussion.id = UUID()
        discussion.content = content
        discussion.numLikes = 0
        discussion.numReplies = 0
        discussion.numShares = 0
        discussion.target = target
        discussion.timestamp = Date()
        discussion.username = user
        discussion.targetType = targetType
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    // alert message
    var discussionCreationAlert: Any {
        Alert(
            title: Text("Sorry Mate"),
            message: Text("please choose a uni / lecturer to write about before you start a discussion and the length of content must be between 0 and 500 characters . "),
            dismissButton: .default(
                Text("Alright")
            )
        )
    }
}

// preview
struct WritePostView_Previews: PreviewProvider {
    static var previews: some View {
        WritePostView()
    }
}
