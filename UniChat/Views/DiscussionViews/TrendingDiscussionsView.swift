//
//  TrendingDiscussionsView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/22.
//

import SwiftUI
 
/// Displays all discussions ordered by number or likes and timestamp
struct TrendingDiscussionsView: View {
    // for custom back button dismiss action
    @Environment(\.dismiss) private var dismiss

    // get context from core data
    @Environment(\.managedObjectContext) var context
    
    // fetch discussions from core data
    @FetchRequest(
        entity: Discussion.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \Discussion.numLikes, ascending: false) ])
    var discussions: FetchedResults<Discussion>
    
    // for tab selection
    @State var uniTabSelected = true
    @State var lecturerTabSelected = false
    
    // to limit the number of characters shown on preview
    let contentPrevCharaters: Int = 110
    
    var body: some View {
        VStack(spacing: 0) {
            
            HeadingView(title: "Trending Discussions")
            
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
                
                // uni tab
                if uniTabSelected {
                    let discussions = discussions.sorted {
                        if $0.numLikes == $1.numLikes {
                            return $0.timestamp > $0.timestamp
                        }
                        
                        return $0.numLikes > $1.numLikes
                    }
                    ForEach (discussions.filter {$0.targetType == "uni"}, id:\.self) {discussion in
                        NavigationLink (destination: DiscussionView(discussionID: String("\(discussion.id)"))) {
                            discussionCard(
                                username: discussion.username,
                                target: discussion.target,
                                content: discussion.content,
                                numLikes: Int(discussion.numLikes),
                                numReplies: Int(discussion.numReplies),
                                numShares: Int(discussion.numShares),
                                timestamp: discussion.timestamp,
                                imageDataString: discussion.discussionImage ?? ""
                            )
                        }
                    }
                }
                
                // lecturer tab
                if lecturerTabSelected {
                    let discussions = discussions.sorted {
                        if $0.numLikes == $1.numLikes {
                            return $0.timestamp > $0.timestamp
                        }
                        
                        return $0.numLikes > $1.numLikes
                    }
                    ForEach (discussions.filter {$0.targetType == "lecturer"}, id:\.self) {discussion in
                        NavigationLink (destination: DiscussionView(discussionID: String("\(discussion.id)"))) {
                            discussionCard(
                                username: discussion.username,
                                target: discussion.target,
                                content: discussion.content,
                                numLikes: Int(discussion.numLikes),
                                numReplies: Int(discussion.numReplies),
                                numShares: Int(discussion.numShares),
                                timestamp: discussion.timestamp,
                                imageDataString: discussion.discussionImage ?? ""
                            )
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
                    Text("Trending Discussions")
                        .font(.title.bold())
                        .background(UniChatColor.headerYellow)
                        .foregroundColor(UniChatColor.brown)
                }
            }
        }
    }
    
    /// Display the each discussion is a preview card mode
    /// - Parameters:
    ///   - username: The username that wrote of the discussion
    ///   - target: The target this discussion if for
    ///   - content: The content of this discussion
    ///   - numLikes: The number of likes under this discussion
    ///   - numReplies: The number of replies under this discussion
    ///   - numShares: The number of shares under this discussion
    ///   - timestamp: The timestamp this discussion was created at
    ///   - imageDataString: The image data string this (if any) that was attatched to this discussion
    /// - Returns: A discussion card HStack View
    private func discussionCard(username: String, target: String, content: String, numLikes: Int, numReplies: Int, numShares: Int, timestamp: Date, imageDataString: String) -> some View {
        return HStack {
            VStack {
                Text(username + " 💬 " + target)
                    .font(.custom("user and target", size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                    
                Text(timestamp, style: .offset)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    
                if content.count <= contentPrevCharaters {
                    Text(content).frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .font(.custom("discusison content", size: 15))
                        .padding(.top, 2)
                        .padding(.bottom, 5)
                        .foregroundColor(.primary)
                } else {
                    Text(String(content.prefix(contentPrevCharaters)) + "... view more")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .font(.custom("discusison content", size: 15))
                        .padding(.top, 2)
                        .padding(.bottom, 5)
                        .foregroundColor(.primary)
                }
                
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
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            
            if imageDataString != "" {
                let data = Data(base64Encoded: imageDataString)
                let uiImage = UIImage(data: data!)
            
                Image(uiImage: (uiImage ?? UIImage(systemName: "photo.fill"))!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70)
            }
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
struct TrendingDiscussionsView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingDiscussionsView()
    }
}
