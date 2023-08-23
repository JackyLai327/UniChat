//
//  NotificationsView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/22.
//

import SwiftUI

struct NotificationsView: View {
    
    @ObservedObject var datas = ReadNotifications()
    
    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                Text("Notifications")
                    .font(.largeTitle.bold())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(UniChatColor.headerYellow)
                    .foregroundColor(UniChatColor.brown)
                List (datas.notifications) { notification in
                    ZStack {
                        NavigationLink (destination: PostView(discussion: notification.discussion)) {
                            EmptyView()
                        }
                        .opacity(0.0)
                        .buttonStyle(PlainButtonStyle())
                        HStack {
                            if notification.type == "like" {
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                    .padding(5)
                                    .foregroundColor(UniChatColor.brightYellow)
                                
                                Text("\(notification.sender) liked your discussion.")
                            }
                            
                            if notification.type == "reply" {
                                Image(systemName: "ellipsis.bubble.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                    .padding(5)
                                    .foregroundColor(UniChatColor.brightYellow)
                                
                                Text("\(notification.sender) replied to your discussion.")
                            }
                            
                            if notification.type == "share" {
                                Image(systemName: "arrowshape.turn.up.right.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                    .padding(5)
                                    .foregroundColor(UniChatColor.brightYellow)
                                
                                Text("someone shared your discussion.")
                            }
                            
                            Spacer()
                            
                            Text(notification.timestamp, style: .offset)
                        }
                    }
                }
                .background(UniChatColor.dimmedYellow)
        }
        
    }
    .scrollContentBackground(.hidden)
    }
}
struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
