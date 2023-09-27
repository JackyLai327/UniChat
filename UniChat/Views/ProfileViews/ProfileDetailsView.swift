//
//  ProfileDetailsView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/19.
//

import SwiftUI

struct ProfileDetailsView: View {
    // for dismiss action
    @Environment(\.dismiss) private var dismiss
    
    // to use the context provided by core data
    @Environment(\.managedObjectContext) var context
    
    // to load correct profile
    var profileID: String = ""
    var profileName: String = ""
    var uniImage: URL = URL(string: "")!
    var profileType: String = ""
    
    // to display rate functionality
    @State var ratingExpanded = false
    
    // fetch discussions from core data
    @FetchRequest(
        entity: Discussion.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \Discussion.timestamp, ascending: false) ])
    var discussions: FetchedResults<Discussion>
    
    // fetch uni ratings from core data
    @FetchRequest(
        entity: UniRating.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \UniRating.id, ascending: true) ])
    var uniRatings: FetchedResults<UniRating>
    
    // fetch lecturer ratings from core data
    @FetchRequest(
        entity: LecturerRating.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \LecturerRating.id, ascending: true) ])
    var lecturerRatings: FetchedResults<LecturerRating>
    
    // to limit the number of characters shown on preview
    let contentPrevCharaters: Int = 100
    
    var body: some View {
        VStack (spacing: 0) {
            // heading
            HeadingView(title: profileName)
            
            // prpfile overview
            VStack (spacing: 0) {
                HStack {
                    // uni logo (favicon from uni website)
                    AsyncImage(url: uniImage) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Image(systemName: "photo")
                            .imageScale(.large)
                            .foregroundColor(.gray)
                    }
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipped()
                    .cornerRadius(10)
                    .padding(.leading, 50)
                    .padding(.trailing, 40)
                    
                    // ratings
                    if profileType == "lecturer" {
                        VStack {
                            let lecturerRating = lecturerRatings.first(where: {"\($0.id)" == profileID})
                            ratingCriteria(criteria: "overview", rating: lecturerRating?.overview ?? 0.0)
                                .padding(.bottom, 1)
                                
                            ratingCriteria(criteria: "strictness", rating: lecturerRating?.strictness ?? 0.0)
                                .padding(.bottom, 1)
                                
                            ratingCriteria(criteria: "workload", rating: lecturerRating?.workload ?? 0.0)
                                .padding(.bottom, 1)
                                
                            ratingCriteria(criteria: "fun", rating: lecturerRating?.fun ?? 0.0)
                                .padding(.bottom, 1)
                        }
                        .padding(.trailing, 40)
                    } else if profileType == "uni" {
                        VStack {
                            let uniRating = uniRatings.first(where: {"\($0.id)" == profileID})
                            ratingCriteria(criteria: "overview", rating: uniRating?.overview ?? 0.0)
                                .padding(.bottom, 1)
                                
                            ratingCriteria(criteria: "practicality", rating: uniRating?.practicality ?? 0.0)
                                .padding(.bottom, 1)
                                
                            ratingCriteria(criteria: "food", rating: uniRating?.food ?? 0.0)
                                .padding(.bottom, 1)
                                
                            ratingCriteria(criteria: "friendliness", rating: uniRating?.friendliness ?? 0.0)
                                .padding(.bottom, 1)
                        }
                        .padding(.trailing, 40)
                    }
                }
                .padding(.vertical, 20)
                
                Divider()
                    .frame(height: 1)
                    .overlay(UniChatColor.brown)
                
                if profileType == "uni" {
                    
                    if !ratingExpanded {
                        Button ("🌕 - rate my uni - 🌕") {
                            ratingExpanded = true
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 7)
                        
                        Divider()
                            .frame(height: 1)
                            .overlay(UniChatColor.brown)
                    } else {
                        Button ("🌕 - rate my uni - 🌕") {
                            ratingExpanded = false
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 7)
                        
                        // TODO: rating functionality
                        VStack {
                            
                        }
                        
                        Divider()
                            .frame(height: 1)
                            .overlay(UniChatColor.brown)
                    }
                    
                    
                } else if profileType == "lecturer" {
                    
                    if !ratingExpanded {
                        Button ("🌕 - rate my lecturer - 🌕") {
                            ratingExpanded = true
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 7)
                        
                        Divider()
                            .frame(height: 1)
                            .overlay(UniChatColor.brown)
                    } else {
                        Button ("🌕 - rate my lecturer - 🌕") {
                            ratingExpanded = false
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 7)
                        
                        // TODO: rating functionality
                        VStack {
                            Text("implement")
                        }
                        
                        Divider()
                            .frame(height: 1)
                            .overlay(UniChatColor.brown)
                    }
                }
            }
            .background(UniChatColor.white)
            
            // discussions related to this profile
            ScrollView {
                let targetDiscussions = discussions.filter({$0.target == profileName})
                
                if targetDiscussions.count == 0 {
                    noDiscussions
                }
                
                ForEach(targetDiscussions, id: \.self) { discussion in
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
            .frame(maxWidth: .infinity)
            .background(UniChatColor.dimmedYellow)
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
    
    // shown when no discussion related to this profile is found
    var noDiscussions: some View {
        VStack {
            Text("there are no discussions\nabout this profile yet ...")
                .font(.title2.bold())
                .multilineTextAlignment(.center)
                .padding(.top, 100)
            Text("🙈")
                .font(.custom("emoji", size: 60))
        }
    }
    
    // display the each discussion is a preview card mode
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
    
    // rating criteria
    func ratingCriteria(criteria: String, rating: Double) -> some View {
        return VStack {
            Text(criteria)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.primary)
            
            Text(Helper().ratingToStars(rating: rating))
                .padding(.leading, -20)
        }
    }
    
    // customised back button for application
    var customBackButton: some View {
        Image(systemName: "chevron.left")
            .font(.title.bold())
            .foregroundColor(UniChatColor.brightYellow)
    }
}

struct ProfileDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailsView(profileID: "Preview", profileName: "Shekhar Kalra", uniImage: URL(string: "http://www.rmit.edu.au//etc.clientlibs/rmit/clientlibs/clientlib-site/resources/favicon.png")!, profileType: "lecturer")
    }
}
