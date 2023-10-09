//
//  NotificationsView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/22.
//

import SwiftUI

/// Displays all notifications for the logged in user
struct NotificationsView: View {
    // to use the context provided by core data
    @Environment(\.managedObjectContext) var context
    
    // fetch notifications from core data
    @FetchRequest(
        entity: Notification.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \Notification.timestamp, ascending: false) ])
    var coreDataNotifications: FetchedResults<Notification>
    
    // user defaults
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack (spacing: 0) {
            HeadingView(title: "Notifications")
            
            ScrollView {
                // display all notifications sent to the current user
                let notifications = coreDataNotifications.filter({$0.receiver == defaults.string(forKey: "currentUsername") ?? ""})
                
                ForEach (notifications, id: \.self) {notification in
                    NavigationLink (destination: DiscussionView(discussionID: "\(notification.discussion)")) {
                        VStack {
                            HStack {
                                // like type notifications layout
                                if notification.notificationType == .like {
                                    Image(systemName: "heart.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25)
                                        .padding(5)
                                        .foregroundColor(UniChatColor.brightYellow)
                                    
                                    Text("\(notification.sender) liked your discussion.")
                                        .font(.custom("", size: 15))
                                        .foregroundColor(.primary)
                                        .multilineTextAlignment(.leading)
                                }
                                
                                // reply type notification layout
                                if notification.notificationType == .reply {
                                    Image(systemName: "ellipsis.bubble.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25)
                                        .padding(5)
                                        .foregroundColor(UniChatColor.brightYellow)
                                    
                                    Text("\(notification.sender) replied to your discussion.")
                                        .font(.custom("", size: 15))
                                        .foregroundColor(.primary)
                                        .multilineTextAlignment(.leading)
                                }
                                
                                // share type notification layout
                                if notification.notificationType == .share {
                                    Image(systemName: "arrowshape.turn.up.right.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25)
                                        .padding(5)
                                        .foregroundColor(UniChatColor.brightYellow)
                                    
                                    Text("someone shared your discussion.")
                                        .font(.custom("", size: 15))
                                        .foregroundColor(.primary)
                                        .multilineTextAlignment(.leading)
                                }
                                
                                Spacer()
                                
                                // how long this notification has been posted
                                Text(notification.timestamp, style: .offset)
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            
                            Divider()
                        }
                    }
                }
            }
        }
        .background(UniChatColor.dimmedYellow)
    }
}

// Preview
struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
