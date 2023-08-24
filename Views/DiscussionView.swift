//
//  PostView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/23.
//

import SwiftUI

struct DiscussionView: View {
    // to hid navigation bar title space
    @State var isNavigationBarHidden: Bool = true
    // for dismiss action
    @Environment(\.dismiss) private var dismiss
    // load data from discussions and replies
    @ObservedObject var datas = ReadDiscussions()
    @ObservedObject var repliesDatas = ReadReplies()
    // to load the correct discussion
    var discussionID: String
    
    
    var body: some View {
        VStack (spacing: 0) {
            HeadingView(title: "Discussion")
            ScrollView {
                contentArea
                repliesSection
            }
            joinDiscussionField
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(self.isNavigationBarHidden)
            .onAppear {
                self.isNavigationBarHidden = true
            }
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
                    .font(.custom("discussion", size: 15))
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
    
    var repliesSection: some View {
        VStack {
            let replies = repliesDatas.replies.filter({$0.discussion == discussionID}).sorted(by: {$0.numUps > $1.numUps})
            
            if replies.count > 0 {
                ForEach(replies, id:\.self) { reply in
                    HStack {
                        VStack {
                            HStack {
                                Text("\(reply.user)")
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
                    Divider()
                        .overlay(UniChatColor.brown)
                }
            } else {
                noRepliesFound
            }
        }
    }
    
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
                Text("join this discussion ...")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(UniChatColor.brown)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
            }
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
    
    var noRepliesFound: some View {
        VStack {
            Text("no one joined this discussion yet,")
            Text("🌵")
                .font(.custom("cactus", size: 100))
            Text("care to be the first?")
        }
        .foregroundColor(UniChatColor.brown)
        .padding(.vertical, 20)
    }
}

struct DiscussionView_Previews: PreviewProvider {
    static var previews: some View {
        DiscussionView(discussionID: "A0001")
    }
}
