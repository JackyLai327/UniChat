//
//  ProfileDetailsView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/19.
//

import SwiftUI

/// Displays ratings of profile and discussions targeted to this profile
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
    
    // for lecturer rating
    @State var lecturerOverviewRating: [String] = ["🌑","🌑","🌑","🌑","🌑"]
    @State var lecturerWorkloadRating: [String] = ["🌑","🌑","🌑","🌑","🌑"]
    @State var lecturerStrictnessRating: [String] = ["🌑","🌑","🌑","🌑","🌑"]
    @State var lecturerFunRating: [String] = ["🌑","🌑","🌑","🌑","🌑"]
    
    // for uni rating
    @State var uniOverviewRating: [String] = ["🌑","🌑","🌑","🌑","🌑"]
    @State var uniPracticalityRating: [String] = ["🌑","🌑","🌑","🌑","🌑"]
    @State var uniFriendlinessRating: [String] = ["🌑","🌑","🌑","🌑","🌑"]
    @State var uniFoodRating: [String] = ["🌑","🌑","🌑","🌑","🌑"]
    
    var body: some View {
        VStack (spacing: 0) {
            // heading
            HeadingView(title: "")
            
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
                        .font(.headline)
                        .foregroundColor(UniChatColor.brown)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 7)
                        
                        Divider()
                            .frame(height: 1)
                            .overlay(UniChatColor.brown)
                    } else {
                        Button ("🌕 - rate my uni - 🌕") {
                            ratingExpanded = false
                        }
                        .font(.headline)
                        .foregroundColor(UniChatColor.brown)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 7)
                        
                        VStack {
                            HStack {
                                VStack {
                                    Text("overview")
                                        .font(.headline)
                                    HStack (spacing: 0) {
                                        ForEach(0..<uniOverviewRating.count, id: \.self) { index in
                                            Button(uniOverviewRating[index])
                                            {
                                                uniOverviewRating = Helper().ratingToStars(rating: Double(index) + 1).map {String($0)}
                                            }
                                        }
                                    }
                                    .padding(.leading, -40)
                                    .padding(.bottom, 10)
                                    
                                    Text("food")
                                        .font(.headline)
                                    HStack (spacing: 0) {
                                        ForEach(0..<uniFoodRating.count, id: \.self) { index in
                                            Button(uniFoodRating[index])
                                            {
                                                uniFoodRating = Helper().ratingToStars(rating: Double(index) + 1).map {String($0)}
                                            }
                                        }
                                    }
                                    .padding(.leading, -40)
                                    .padding(.bottom, 10)
                                    
                                }
                                .padding(.horizontal, 40)
                                
                                VStack {
                                    Text("practicality")
                                        .font(.headline)
                                    HStack (spacing: 0) {
                                        ForEach(0..<uniPracticalityRating.count, id: \.self) { index in
                                            Button(uniPracticalityRating[index])
                                            {
                                                uniPracticalityRating = Helper().ratingToStars(rating: Double(index) + 1).map {String($0)}
                                            }
                                        }
                                    }
                                    .padding(.trailing, -40)
                                    .padding(.bottom, 10)
                                    
                                    Text("friendliness")
                                        .font(.headline)
                                    HStack (spacing: 0) {
                                        ForEach(0..<uniFriendlinessRating.count, id: \.self) { index in
                                            Button(uniFriendlinessRating[index])
                                            {
                                                uniFriendlinessRating = Helper().ratingToStars(rating: Double(index) + 1).map {String($0)}
                                            }
                                        }
                                    }
                                    .padding(.trailing, -40)
                                    .padding(.bottom, 10)
                                }
                                .padding(.horizontal, 50)
                            }
                            
                            Button(action: {
                                if profileType == "uni" {
                                    // convert user input into double
                                    let overviewRating = Helper().starsToRating(stars: uniOverviewRating.joined())
                                    let practicalityRating = Helper().starsToRating(stars: uniPracticalityRating.joined())
                                    let foodRating = Helper().starsToRating(stars: uniFoodRating.joined())
                                    let friendlinessRating = Helper().starsToRating(stars: uniFriendlinessRating.joined())
                                    
                                    if let averageRating = uniRatings.first(where: {"\($0.id)" == profileID}) {
                                        if (averageRating.numRatings == 0) {
                                            averageRating.numRatings += 1
                                            averageRating.overview = overviewRating
                                            averageRating.practicality = practicalityRating
                                            averageRating.food = foodRating
                                            averageRating.friendliness = friendlinessRating
                                        } else {
                                            averageRating.numRatings += 1
                                            averageRating.overview = Helper().calculateAverage(averageRating: averageRating.overview, newRating: overviewRating, count: averageRating.numRatings)
                                            averageRating.practicality = Helper().calculateAverage(averageRating: averageRating.practicality, newRating: practicalityRating, count: averageRating.numRatings)
                                            averageRating.food = Helper().calculateAverage(averageRating: averageRating.food, newRating: foodRating, count: averageRating.numRatings)
                                            averageRating.friendliness = Helper().calculateAverage(averageRating: averageRating.friendliness, newRating: friendlinessRating, count: averageRating.numRatings)
                                        }
                                        
                                        try! context.save()
                                        ratingExpanded = false
                                    }
                                }
                                
                            }) {
                                Text("submit")
                                    .foregroundColor(UniChatColor.brown)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 5)
                                    .background(
                                        Capsule()
                                            .strokeBorder(UniChatColor.brown, lineWidth: 2)
                                            .background(UniChatColor.headerYellow)
                                    )
                            }
                            .padding(.bottom, 10)
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
                        .font(.headline)
                        .foregroundColor(UniChatColor.brown)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 7)
                        
                        Divider()
                            .frame(height: 1)
                            .overlay(UniChatColor.brown)
                    } else {
                        Button ("🌕 - rate my lecturer - 🌕") {
                            ratingExpanded = false
                        }
                        .font(.headline)
                        .foregroundColor(UniChatColor.brown)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 7)
                        
                        VStack {
                            HStack {
                                VStack {
                                    Text("overview")
                                        .font(.headline)
                                    HStack (spacing: 0) {
                                        ForEach(0..<lecturerOverviewRating.count, id: \.self) { index in
                                            Button(lecturerOverviewRating[index])
                                            {
                                                lecturerOverviewRating = Helper().ratingToStars(rating: Double(index) + 1).map {String($0)}
                                            }
                                        }
                                    }
                                    .padding(.leading, -40)
                                    .padding(.bottom, 10)
                                    
                                    Text("strictness")
                                        .font(.headline)
                                    HStack (spacing: 0) {
                                        ForEach(0..<lecturerStrictnessRating.count, id: \.self) { index in
                                            Button(lecturerStrictnessRating[index])
                                            {
                                                lecturerStrictnessRating = Helper().ratingToStars(rating: Double(index) + 1).map {String($0)}
                                            }
                                        }
                                    }
                                    .padding(.leading, -40)
                                    .padding(.bottom, 10)
                                    
                                }
                                .padding(.horizontal, 40)
                                
                                VStack {
                                    Text("workload")
                                        .font(.headline)
                                    HStack (spacing: 0) {
                                        ForEach(0..<lecturerWorkloadRating.count, id: \.self) { index in
                                            Button(lecturerWorkloadRating[index])
                                            {
                                                lecturerWorkloadRating = Helper().ratingToStars(rating: Double(index) + 1).map {String($0)}
                                            }
                                        }
                                    }
                                    .padding(.trailing, -40)
                                    .padding(.bottom, 10)
                                    
                                    Text("fun")
                                        .font(.headline)
                                    HStack (spacing: 0) {
                                        ForEach(0..<lecturerFunRating.count, id: \.self) { index in
                                            Button(lecturerFunRating[index])
                                            {
                                                lecturerFunRating = Helper().ratingToStars(rating: Double(index) + 1).map {String($0)}
                                            }
                                        }
                                    }
                                    .padding(.trailing, -40)
                                    .padding(.bottom, 10)
                                }
                                .padding(.horizontal, 50)
                            }
                            
                            Button(action: {
                                if profileType == "lecturer" {
                                    // convert user input into double
                                    let overviewRating = Helper().starsToRating(stars: lecturerOverviewRating.joined())
                                    let strictnessRating = Helper().starsToRating(stars: lecturerStrictnessRating.joined())
                                    let workloadRating = Helper().starsToRating(stars: lecturerWorkloadRating.joined())
                                    let funRating = Helper().starsToRating(stars: lecturerFunRating.joined())
                                    
                                    if let averageRating = lecturerRatings.first(where: {"\($0.id)" == profileID}) {
                                        if (averageRating.numRatings == 0) {
                                            averageRating.numRatings += 1
                                            averageRating.overview = overviewRating
                                            averageRating.strictness = strictnessRating
                                            averageRating.workload = workloadRating
                                            averageRating.fun = funRating
                                        } else {
                                            averageRating.numRatings += 1
                                            averageRating.overview = Helper().calculateAverage(averageRating: averageRating.overview, newRating: overviewRating, count: averageRating.numRatings)
                                            averageRating.strictness = Helper().calculateAverage(averageRating: averageRating.strictness, newRating: strictnessRating, count: averageRating.numRatings)
                                            averageRating.workload = Helper().calculateAverage(averageRating: averageRating.workload, newRating: workloadRating, count: averageRating.numRatings)
                                            averageRating.fun = Helper().calculateAverage(averageRating: averageRating.fun, newRating: funRating, count: averageRating.numRatings)
                                        }
                                        
                                        try! context.save()
                                        ratingExpanded = false
                                    }
                                }
                                
                            }) {
                                Text("submit")
                                    .foregroundColor(UniChatColor.brown)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 5)
                                    .background(
                                        Capsule()
                                            .strokeBorder(UniChatColor.brown, lineWidth: 2)
                                            .background(UniChatColor.headerYellow)
                                    )
                            }
                            .padding(.bottom, 10)
                        }
                        
                        Divider()
                            .frame(height: 1)
                            .overlay(UniChatColor.brown)
                    }
                }
            }
            .background(UniChatColor.headerYellow)
            
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
                            timestamp: discussion.timestamp,
                            imageDataString: discussion.discussionImage ?? ""
                        )
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
                Text(profileName)
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
    
    /// Rating criteria
    /// - Parameters:
    ///   - criteria: The criteria the of the rating for this profile
    ///   - rating: The rating of that criteria for this profile
    /// - Returns: A rating criteria HStack View
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
        ProfileDetailsView(profileID: "Preview", profileName: "Royal Mlebourne Institute of Technology", uniImage: URL(string: "http://www.rmit.edu.au//etc.clientlibs/rmit/clientlibs/clientlib-site/resources/favicon.png")!, profileType: "uni")
    }
}
