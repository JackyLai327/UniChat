//
//  PostView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/23.
//

import SwiftUI

/// Displays a discussion along with all the replies.
/// Allows a user to like this discussion and copy link to website version of this application.
struct DiscussionView: View {
    // for dismiss action
    @Environment(\.dismiss) private var dismiss
    
    // to use the context provided by core data
    @Environment(\.managedObjectContext) var context
    
    // to show delete reply
    @State var showDelete = false

    
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
    
    // fetch notifications from core data
    @FetchRequest(
        entity: Notification.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \Notification.timestamp, ascending: false) ])
    var notifications: FetchedResults<Notification>
    
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
                    
                    VStack {
                        Text(discussion.timestamp, style: .date)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        if defaults.string(forKey: "currentUsername") == discussion.username {
                            Text("delete")
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundColor(.secondary)
                                .onTapGesture {
                                    do {
                                        context.delete(discussion)
                                        try context.save()
                                    } catch {
                                        print(error)
                                    }
                                }
                        }
                    }
                    .frame(width: 100)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                .padding(.top, 30)
              
                
                if discussion.discussionImage != nil {
                    let data = Data(base64Encoded: discussion.discussionImage!)
                    let uiImage = UIImage(data: data!)
                    
                    Text(discussion.content)
                        .font(.custom("discussion", size: 15))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                    
                    Image(uiImage: (uiImage ?? UIImage(systemName: "photo.fill"))!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .frame(width: 200)
                        .padding(.bottom, 20)
                } else {
                    Text(discussion.content)
                        .font(.custom("discussion", size: 15))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 30)
                }
                
                VStack (spacing: 0) {
                    Divider()
                        .frame(height: 1)
                        .overlay(UniChatColor.brown)
                    HStack {
                        Button {
                            let currentUsername = UserDefaults.standard.string(forKey: "currentUsername")!
                            
                            if let user = discussion.likedUserArray.first(where: {$0.username == currentUsername}) {
                                pressLike(discussion: discussion, user: user, operation: -1)
                            } else {
                                let user = LikedUser(context: context)
                                user.username = currentUsername
                                
                                try? context.save()
                                
                                pressLike(discussion: discussion, user: user, operation: 1)
                            }
                        } label: {
                            let currentUsername = UserDefaults.standard.string(forKey: "currentUsername")!
                            
                            if let user = discussion.likedUserArray.first(where: {$0.username == currentUsername}) {
                                HStack {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(UniChatColor.brightYellow)
                                    Text("\(discussion.numLikes)")
                                        .foregroundColor(UniChatColor.brown)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 5)
                            } else {
                                HStack {
                                    Image(systemName: "heart")
                                        .foregroundColor(UniChatColor.brightYellow)
                                    Text("\(discussion.numLikes)")
                                        .foregroundColor(UniChatColor.brown)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 5)
                            }
                        }
                        
                        Divider()
                            .frame(width: 1)
                            .overlay(UniChatColor.brown)
                        
                        Button {
                            // MARK: share is copying the link to the desktop version of the app on this discussion, which is for another app development
                            pressShare(discussion: discussion)
                            UIPasteboard.general.string = "https://www.apple.com"
                        } label: {
                            HStack {
                                Image(systemName: "link")
                                    .foregroundColor(UniChatColor.brightYellow)
                                Text("copy link")
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
        
        return VStack {
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
                            // up mechanism
                            let currentUsername = UserDefaults.standard.string(forKey: "currentUsername")!
                            
                            if let user = reply.upUserArray.first(where: {$0.username == currentUsername}) {
                                pressUp(reply: reply, user: user, operation: -1)
                            } else {
                                let user = UpUser(context: context)
                                user.username = currentUsername
                                
                                try? context.save()
                                
                                pressUp(reply: reply, user: user, operation: 1)
                            }
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
                        if $showDelete.wrappedValue && reply.username == defaults.string(forKey: "currentUsername") {
                            Text("delete")
                                .padding(5)
                                .background(.red)
                                .foregroundColor(Color.white)
                                .cornerRadius(25)
                                .padding(.trailing, 5)
                                .onTapGesture {
                                    do {
                                        context.delete(reply)
                                        discussions.first(where: {"\($0.id)" == reply.discussion})?.numReplies -= 1
                                        try context.save()
                                    } catch {
                                        print(error)
                                    }
                                }
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if reply.username == defaults.string(forKey: "currentUsername") {
                            showDelete = !showDelete
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
                        let currentUsername = defaults.string(forKey: "currentUsername")
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
            Text("🧌")
                .font(.custom("Troll", size: 70))
                .padding(.top, 200)
            Text("This discussion is devoured by trolls...")
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.headline.bold())
                .foregroundColor(UniChatColor.brown)
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
    
    /// Creates a new reply for the dedicated discussion.
    /// Also creates a notification to notify the user of the discussion.
    /// - Parameters:
    ///   - content: The content of the reply
    ///   - discussion: The Discussion this reply is attatched to
    ///   - user: The user who wrote this reply
    func createReply(content: String, discussion: Discussion, user: String) {
        let reply = Reply(context: context)
        reply.id = UUID()
        reply.content = content
        reply.discussion = "\(discussion.id)"
        reply.numUps = 0
        reply.timestamp = Date()
        reply.username = user

        discussion.numReplies += 1
        
        let notification = Notification(context: context)
        notification.id = UUID()
        notification.discussion = "\(discussion.id)"
        notification.notificationType = NotificationType.reply
        notification.receiver = discussion.username
        notification.sender = defaults.string(forKey: "currentUsername") ?? "unknown"
        notification.timestamp = Date()
        
        print(notification)
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    /// Adds the user to the upUser array of the dedicated reply (or remove).
    /// If operation = 1 => add.
    /// - Parameters:
    ///   - reply: The reply a user is tyring to up
    ///   - user: The user who ups this reply
    ///   - operation: If operation = 1 => up, if operation = -1 => de-up.
    func pressUp(reply: Reply, user: UpUser, operation: Int32) {
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
    
    // adds the user to the like user array of the dedicated reply (or remove)
    // if operation = 1 => add
    // if operation = -1 => remove
    // create a notification for liking a discussion
    func pressLike(discussion: Discussion, user: LikedUser, operation: Int32) {
        if operation == 1 {
            discussion.addToLikedUser(user)
            
            let notification = Notification(context: context)
            notification.id = UUID()
            notification.discussion = "\(discussion.id)"
            notification.notificationType = NotificationType.like
            notification.receiver = discussion.username
            notification.sender = defaults.string(forKey: "currentUsername") ?? "unknown"
            notification.timestamp = Date()
        }
        if operation == -1 {
            discussion.removeFromLikedUser(user)
            let username = defaults.string(forKey: "currentUsername")
            if let notification = notifications.first(where: {$0.sender == username && $0.discussion == "\(discussion.id)"}) {
                context.delete(notification)
            }
        }
        discussion.numLikes += operation
        
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    /// Add num of share by 1 and create a notification for it
    /// - Parameter discussion: The discussion that is being shared
    func pressShare(discussion: Discussion) {
        discussion.numShares += 1
        
        let notification = Notification(context: context)
        notification.id = UUID()
        notification.discussion = "\(discussion.id)"
        notification.notificationType = NotificationType.share
        notification.receiver = discussion.username
        notification.sender = defaults.string(forKey: "currentUsername") ?? "unknown"
        notification.timestamp = Date()
        
        
        try! context.save()
    }
}

struct DiscussionView_Previews: PreviewProvider {
    static var previews: some View {
        DiscussionView(discussionID: "ACA005C5-64C8-43E2-BC72-8898400994AE")
    }
}
