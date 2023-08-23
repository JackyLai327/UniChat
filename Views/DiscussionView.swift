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
    // load data from discussions
    @ObservedObject var datas = ReadDiscussions()
    // to load the correct discussion
    var discussionID: String
    
    var body: some View {
        VStack (spacing: 0) {
            HeadingView(title: "Discussion")
            contentArea
            repliesSection
        }
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        customBackButton
                    }
                }
            }
    }
    
    var contentArea: some View {
        VStack {
            ScrollView {
                if let discussion = datas.discussions.first(where: {$0.discussion == discussionID}) {
                    HStack {
                        VStack {
                            Text("🗣️ \(discussion.user)")
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
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                    Text(discussion.images[0])
                        .frame(width: 150, height: 150)
                        .border(.black)
                        .padding(.bottom, 20)
                    VStack (spacing: 0) {
                        Divider()
                            .frame(height: 1)
                            .overlay(UniChatColor.brown)
                        HStack {
                            
                            HStack {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(UniChatColor.brightYellow)
                                Text("\(discussion.numLikes)")
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 5)
                            
                            Divider()
                                .frame(width: 1)
                                .overlay(UniChatColor.brown)
                            
                            HStack {
                                Image(systemName: "arrowshape.turn.up.right.fill")
                                    .foregroundColor(UniChatColor.brightYellow)
                                Text("\(discussion.numShares)")
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 5)
                        }
                        Divider()
                            .frame(height: 1)
                            .overlay(UniChatColor.brown)
                    }
                } else {
                    discussionNotFound
                    Spacer()
                }
            }
        }
    }
    
    var repliesSection: some View {
        VStack {
            
        }
    }
    
    var customBackButton: some View {
        Image(systemName: "chevron.left")
            .font(.title.bold())
            .foregroundColor(UniChatColor.brightYellow)
    }
    
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
}

struct DiscussionView_Previews: PreviewProvider {
    static var previews: some View {
        DiscussionView(discussionID: "A0001")
    }
}
