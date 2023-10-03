//
//  MyDiscussionsView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/22.
//

import SwiftUI

struct MyDiscussionsView: View {
    // for custom back button dismiss action
    @Environment(\.dismiss) private var dismiss

    // get context from core data
    @Environment(\.managedObjectContext) var context
    
    // fetch discussions from core data
    @FetchRequest(
        entity: Discussion.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \Discussion.numLikes, ascending: false) ])
    var discussions: FetchedResults<Discussion>

    
    // fetch images from core data
    @FetchRequest(
        entity: DiscussionImage.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \DiscussionImage.timestamp, ascending: false) ])
    var images: FetchedResults<DiscussionImage>
    
    // user defaults to store user details
    let defaults = UserDefaults.standard
    
    // for tab selection
    @State var uniTabSelected = true
    @State var lecturerTabSelected = false
    
    // to limit the number of characters shown on preview
    let contentPrevCharaters: Int = 100
    
    var body: some View {
        VStack(spacing: 0) {
            
            HeadingView(title: "")
            
            HStack {
                // tab Unis
                Button {
                    uniTabSelected = true
                    lecturerTabSelected = false
                } label: {
                    VStack (spacing: 0) {
                        Text("Unis")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                        uniTabSelected ? Divider().frame(height: 2).overlay(UniChatColor.brown) : nil
                    }
                }
                
                // tab Lecturers
                Button {
                    uniTabSelected = false
                    lecturerTabSelected = true
                } label: {
                    VStack (spacing: 0){
                        Text("Lecturers")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                        lecturerTabSelected ? Divider().frame(height: 2).overlay(UniChatColor.brown) : nil
                    }
                }
            }
            .font(.title3 .bold())
            .background(UniChatColor.headerYellow)
            .foregroundColor(UniChatColor.brown)
            
            ScrollView{
                
                let myDiscussions = discussions.filter({$0.username == defaults.string(forKey: "currentUsername") })
                
                // uni tab
                if uniTabSelected {
                    ForEach (myDiscussions.filter {$0.targetType == "uni"}, id:\.self) {discussion in
                        NavigationLink (destination: DiscussionView(discussionID: String("\(discussion.id)"))) {
                            discussionCard(
                                username: discussion.username,
                                target: discussion.target,
                                content: discussion.content,
                                numLikes: Int(discussion.numLikes),
                                numReplies: Int(discussion.numReplies),
                                numShares: Int(discussion.numShares),
                                timestamp: discussion.timestamp)
                        }
                    }
                }
                
                // lecturer tab
                if lecturerTabSelected {
                    ForEach (myDiscussions.filter {$0.targetType == "lecturer"}, id:\.self) {discussion in
                        NavigationLink (destination: DiscussionView(discussionID: String("\(discussion.id)"))) {
                            discussionCard(
                                username: discussion.username,
                                target: discussion.target,
                                content: discussion.content,
                                numLikes: Int(discussion.numLikes),
                                numReplies: Int(discussion.numReplies),
                                numShares: Int(discussion.numShares),
                                timestamp: discussion.timestamp)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(UniChatColor.dimmedYellow)
            // custom back button
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("My Discussions")
                        .font(.title.bold())
                        .background(UniChatColor.headerYellow)
                        .foregroundColor(UniChatColor.brown)
                }
            }
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
                Text("My Discussion")
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
    
    // display the each discussion is a preview card mode
    private func discussionCard(username: String, target: String, content: String, numLikes: Int, numReplies: Int, numShares: Int, timestamp: Date) -> some View {
        return HStack {
            VStack {
                Text(username + " • " + target)
                    .font(.headline .bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                    
                Text(timestamp, style: .offset)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    
                Text(String(content.prefix(contentPrevCharaters)) + "... view more")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .font(.custom("discusison content", size: 15))
                    .padding(.bottom, 5)
                    .foregroundColor(.primary)
                
                HStack {
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(UniChatColor.brightYellow)
                        Text("\(numLikes)")
                            .font(.custom("discusison content", size: 15))
                            .foregroundColor(.primary)
                    }
                    .padding(.trailing, 5)
                    HStack {
                        Image(systemName: "ellipsis.bubble")
                            .foregroundColor(UniChatColor.brightYellow)
                        Text("\(numReplies)")
                            .font(.custom("discusison content", size: 15))
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal, 5)
                    HStack {
                        Image(systemName: "arrowshape.turn.up.right.fill")
                            .foregroundColor(UniChatColor.brightYellow)
                        Text("\(numShares)")
                            .font(.custom("discusison content", size: 15))
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal, 5)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Image("trendingDiscussions")
                .resizable()
                .scaledToFit()
                .frame(width: 70)
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(UniChatColor.headerYellow)
        .cornerRadius(10)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .shadow(radius: 3)
    }
}

// preview
struct MyDiscussionsView_Previews: PreviewProvider {
    static var previews: some View {
        MyDiscussionsView()
    }
}
