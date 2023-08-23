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
            heading
            contentArea
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
    
    var heading: some View {
        VStack (spacing: 0) {
            Text("Discussion")
                .font(.largeTitle.bold())
                .padding()
                .frame(maxWidth: .infinity)
                .background(UniChatColor.headerYellow)
                .foregroundColor(UniChatColor.brown)
            Divider()
                .frame(width: .infinity, height: 1)
                .overlay(UniChatColor.brown)
        }
    }
    
    var contentArea: some View {
        VStack {
            VStack {
                if let discussion = datas.discussions.first(where: {$0.discussion == discussionID}) {
                    Text("🗣️ \(discussion.user)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title2)
                        .foregroundColor(UniChatColor.brown)
                        .padding(.horizontal, 30)
                        .padding(.top, 50)
                    Text("🎓 \(discussion.target)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title3)
                        .foregroundColor(UniChatColor.brown)
                        .padding(.horizontal, 30)
                } else {
                    Text("This discussion is devoured by trolls...")
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.title.bold())
                        .foregroundColor(UniChatColor.brown)
                        .padding(.top, 100)
                        .padding(.bottom, 50)
                    Text("🧌")
                        .font(.custom("Troll", size: 200))
                    
                    Spacer()
                }
            }
        }
    }
    
    var customBackButton: some View {
        Image(systemName: "chevron.left")
            .font(.title.bold())
            .foregroundColor(UniChatColor.brightYellow)
    }
}

struct DiscussionView_Previews: PreviewProvider {
    static var previews: some View {
        DiscussionView(discussionID: "A000")
    }
}
