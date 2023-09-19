//
//  PostView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/23.
//

import SwiftUI

struct DiscussionView: View {
    // for dismiss action
    @Environment(\.dismiss) private var dismiss
    
    // to use the context provided by core data
    @Environment(\.managedObjectContext) var context
    
    // fetch discussions from core data
    @FetchRequest(
        entity: Discussion.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \Discussion.timestamp, ascending: false) ])
    var discussions: FetchedResults<Discussion>
    
    // fetch users from core data
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \User.username, ascending: true) ])
    var users: FetchedResults<User>
    
    // to load the correct discussion
    var discussionID: String
    
    // for user to write a new reply
    @State var newReply: String = ""
    
    // user defaults
    let defaults = UserDefaults.standard
    
    // fetching replies in a descending order by numUps
    @FetchRequest(
        entity: Reply.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \Reply.timestamp, ascending: false) ])
    var replies: FetchedResults<Reply>
    
    
    var body: some View {
        VStack (spacing: 0) {
            
            HeadingView(title: "")
            
            if let discussion = discussions.first(where: {"\($0.id)" == discussionID}) {
                
                // if discussion has replies, display content + replies
                if discussion.numReplies > 0 {
                    ScrollView {
                        contentArea
                        repliesSection
                    }
                    joinDiscussionField
                    
                // if discussion has no replies but content, display content
                } else {
                    ScrollView {
                        contentArea
                        noRepliesFound
                    }
                    joinDiscussionField
                }
                
            // if discussion is not found, display discussion not found view
            } else {
                discussionNotFound
                Spacer()
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
                Text("Discussion")
                    .font(.title2.bold())
                    .background(UniChatColor.headerYellow)
                    .foregroundColor(UniChatColor.brown)
            }
            
        }
    }
    
    // how the discussion is laid out
    var contentArea: some View {
        VStack {
            if let discussion = discussions.first(where: {"\($0.id)" == discussionID}) {
                HStack {
                    VStack {
                        Text("🗣️ \(discussion.username)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .foregroundColor(UniChatColor.brown)
                            
                        Text("🎓 \(discussion.target)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .foregroundColor(UniChatColor.brown)
                    }
                    
                    Spacer()
                    
                    Text(discussion.timestamp, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                .padding(.top, 30)
              
                Text(discussion.content)
                    .font(.custom("discussion", size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                // FIXME: add image stuff in here
//                Image(uiImage: discussion.images)
//                    .frame(width: 150, height: 150)
//                    .border(.black)
//                    .padding(.bottom, 20)
                VStack (spacing: 0) {
                    Divider()
                        .frame(height: 1)
                        .overlay(UniChatColor.brown)
                    HStack {
                        Button {
                            // FIXME: like mechanism needs help
                            print("like +1")
                        } label: {
                            HStack {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(UniChatColor.brightYellow)
                                Text("\(discussion.numLikes)")
                                    .foregroundColor(UniChatColor.brown)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 5)
                        }
                        
                        Divider()
                            .frame(width: 1)
                            .overlay(UniChatColor.brown)
                        
                        Button {
                            // FIXME: share mechanism needs to be implemented
                            print("share +1")
                        } label: {
                            HStack {
                                Image(systemName: "arrowshape.turn.up.right.fill")
                                    .foregroundColor(UniChatColor.brightYellow)
                                Text("\(discussion.numShares)")
                                    .foregroundColor(UniChatColor.brown)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 5)
                        }
                    }
                    Divider()
                        .frame(height: 1)
                        .overlay(UniChatColor.brown)
                }
            }
        }
    }
    
    // contains all the replies for this dedicated discussion
    var repliesSection: some View {
        VStack {
            let replies = replies.filter({$0.discussion == discussionID}).sorted(by: {$0.numUps >= $1.numUps})
            
            if replies.count > 0 {
                ForEach(replies, id:\.self) { reply in
                    HStack {
                        VStack {
                            HStack {
                                Text("\(reply.username)")
                                    .frame(alignment: .leading)
                                    .font(.custom("reply", size: 15).bold())
                                    .foregroundColor(UniChatColor.brown)
                                Text(reply.timestamp, style: .offset)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Text(reply.content)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.custom("reply", size: 15))
                        }
                        .padding(.leading, 20)
                        .padding(.top, 10)
                        
                        Spacer()
                        
                        Button {
                            // FIXME: up mechanism needs help
//                            let currentUsername = UserDefaults.standard.string(forKey: "currentUsername")!
//                            let user = users.first(where: {$0.username == currentUsername})!
//                            if !reply.upUserArray.contains(user) {
//                                pressUp(reply: reply, user: user, operation: 1)
//                            } else {
//                                pressUp(reply: reply, user: user, operation: -1)
//                            }
                        } label: {
                            VStack {
                                Image(systemName: "hand.point.up.fill")
                                    .foregroundColor(UniChatColor.brightYellow)
                                    .scaleEffect(1.2)
                                Text("\(reply.numUps)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("up this")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.trailing, 20)
                            .offset(y: 5)
                        }
                    }
                    Divider()
                        .overlay(UniChatColor.brown)
                }
            } else {
                noRepliesFound
            }
        }
    }
    
    // the input field where people join a discussion (add comments)
    var joinDiscussionField: some View {
        VStack (spacing: 0) {
            Divider()
                .overlay(UniChatColor.brown)
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(UniChatColor.brown, lineWidth: 2)
                    .background(UniChatColor.headerYellow)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .frame(maxHeight: 50)
                TextField("join this discussion ...", text: $newReply)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                Button {
                    if newReply.count > 0 {
                        let currentUsername = UserDefaults.standard.string(forKey: "currentUsername")
                        let discussion = discussions.first(where: {"\($0.id)" == discussionID})
                        createReply(content: newReply, discussion: discussion!, user: currentUsername!)
                        newReply = ""
                    }
                } label: {
                    Image(systemName: "paperplane")
                        .padding(.trailing, 30)
                        .foregroundColor(UniChatColor.brown)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 5)
            }
        }
    }
    
    // customised back button for application
    var customBackButton: some View {
        Image(systemName: "chevron.left")
            .font(.title.bold())
            .foregroundColor(UniChatColor.brightYellow)
    }
    
    // displayed when discussion ID is not stored in core data
    var discussionNotFound: some View {
        VStack {
            Text("This discussion is devoured by trolls...")
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.title.bold())
                .foregroundColor(UniChatColor.brown)
                .padding(.top, 200)
            Text("🧌")
                .font(.custom("Troll", size: 200))
        }
    }
    
    // displayed when this discussion has no replies 
    var noRepliesFound: some View {
        VStack {
            Text("no one joined this discussion yet ,")
            Text("🦘")
                .font(.custom("cactus", size: 100))
            Text("care to be the first ?")
        }
        .foregroundColor(UniChatColor.brown)
        .padding(.vertical, 20)
    }
    
    // creates a new reply for the dedicated discussion
    func createReply(content: String, discussion: Discussion, user: String) {
        let reply = Reply(context: context)
        reply.id = UUID()
        reply.content = content
        reply.discussion = "\(discussion.id)"
        reply.numUps = 0
        reply.timestamp = Date()
        reply.username = user

        discussion.numReplies += 1
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    // adds the user to the upUser array of the dedicated reply (or remove)
    // if operation = 1 => add
    // if operation = -1 => remove
    func pressUp(reply: Reply, user: User, operation: Int32) {
        if operation == 1 {
            reply.addToUpUser(user)
        }
        if operation == -1 {
            reply.removeFromUpUser(user)
        }
        reply.numUps += operation
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

struct DiscussionView_Previews: PreviewProvider {
    static var previews: some View {
        DiscussionView(discussionID: "ACA005C5-64C8-43E2-BC72-8898400994AE")
    }
}
