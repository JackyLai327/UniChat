//
//  NotificationsView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/22.
//

import SwiftUI

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
                // TODO: finish this functionality
                List {
                    let notifications = coreDataNotifications.filter({$0.receiver == defaults.string(forKey: "currentUsername")!})
                    
                    ForEach (notifications) {notification in
                        Text("\(coreDataNotifications.count)")
                        Text("\(notifications.count)")
                        ZStack {
                            NavigationLink (destination: DiscussionView(discussionID: "\(notification.discussion)")) {
                                EmptyView()
                            }
                            .opacity(0.0)
                            .buttonStyle(PlainButtonStyle())
                            
                            HStack {
                                // like type notifications layout
                                if notification.notificationType == .like {
                                    Image(systemName: "heart.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20)
                                        .padding(5)
                                        .foregroundColor(UniChatColor.brightYellow)
                                    
                                    Text("\(notification.sender) liked your discussion.")
                                        .font(.caption)
                                }
                                
                                // reply type notification layout
                                if notification.notificationType == .reply {
                                    Image(systemName: "ellipsis.bubble.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20)
                                        .padding(5)
                                        .foregroundColor(UniChatColor.brightYellow)
                                    
                                    Text("\(notification.sender) replied to your discussion.")
                                        .font(.caption)
                                }
                                
                                // share type notification layout
                                if notification.notificationType == .share {
                                    Image(systemName: "arrowshape.turn.up.right.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20)
                                        .padding(5)
                                        .foregroundColor(UniChatColor.brightYellow)
                                    
                                    Text("someone shared your discussion.")
                                        .font(.caption)
                                }
                                
                                Spacer()
                                
                                // how long this notification has been posted
                                Text(notification.timestamp, style: .offset)
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                        
                    
                }
            }
            .background(UniChatColor.dimmedYellow)
        }
    }
}

// Preview
struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
