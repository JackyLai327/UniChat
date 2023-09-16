//
//  TrendingDiscussionsView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/22.
//

import SwiftUI

struct TrendingDiscussionsView: View {
    // for custom back button dismiss action
    @Environment(\.dismiss) private var dismiss

    // get context from core data
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
        entity: Discussion.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \Discussion.numLikes, ascending: false) ])
    var discussions: FetchedResults<Discussion>
    
    // fetch discussions from core data
//    var discussions = CoreDataModelView.fetchDiscussionsNumLikesDescend()
    
    // fetch images from core data
    @FetchRequest(
        entity: DiscussionImage.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \DiscussionImage.timestamp, ascending: false) ])
    var images: FetchedResults<DiscussionImage>
    
    // for tab selection
    @State var uniTabSelected = true
    @State var lecturerTabSelected = false
    
    // to limit the number of characters shown on preview
    let contentPrevCharaters: Int = 100
    
    var body: some View {
        VStack(spacing: 0) {
            
            HeadingView(title: "Trending Discussions")
            
            HStack {
                VStack(spacing: 0)  {
                    Text("Unis")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    uniTabSelected ? Divider().frame(height: 2).overlay(UniChatColor.brown) : nil
                }
                .onTapGesture {
                    uniTabSelected = true
                    lecturerTabSelected = false
                }
                
                VStack(spacing: 0)  {
                    Text("Lecturers")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    lecturerTabSelected ? Divider().frame(height: 2).overlay(UniChatColor.brown) : nil
                }
                .onTapGesture {
                    uniTabSelected = false
                    lecturerTabSelected = true
                }
            }
            .font(.title3 .bold())
            .background(UniChatColor.headerYellow)
            .foregroundColor(UniChatColor.brown)
            
            ScrollView{
                
                // uni tab
                if uniTabSelected {
                    ForEach (discussions.filter {$0.targetType == "uni"}, id:\.self) {discussion in
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
                    ForEach (discussions.filter {$0.targetType == "lecturer"}, id:\.self) {discussion in
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
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Trending Discussions")
                        .font(.title.bold())
                        .background(UniChatColor.headerYellow)
                        .foregroundColor(UniChatColor.brown)
                }
            }
        }
    }
    
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

struct TrendingDiscussionsView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingDiscussionsView()
    }
}
