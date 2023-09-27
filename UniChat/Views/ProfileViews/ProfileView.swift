//
//  ProfileView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/22.
//

import SwiftUI
import FaviconFinder

struct ProfileView: View {
    // to use the context provided by core data
    @Environment(\.managedObjectContext) var context
    
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
    
    // fetched data is stored in an array of University Data object
    @State var unis = [UniversityData]()
    
    // fetched images will be stored into this dictionary
    @State var uniImages: [String: URL] = [:]
    
    // temporary lecturer list
    @ObservedObject var lecturersData = ReadLecturers()
    
    // for searching universities
    @State var searchKey: String = ""
    
    // for tab selection
    @State var uniTabSelected = true
    @State var lecturerTabSelected = false
    
    var body: some View {
        VStack(spacing: 0) {
            HeadingView(title: "Profiles")
            
            // tabs
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
            
            // search bar
            HStack {
                Image(systemName: "magnifyingglass")
                .foregroundColor(UniChatColor.brown)
                .padding(.leading, 5)
                
                if uniTabSelected {
                    TextField("search for a uni", text: $searchKey)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                        .foregroundColor(UniChatColor.lightBrown)
                        .onChange(of: searchKey) { newValue in
                            Task {
                                try! await searchUnis(query: searchKey) {
                                }
                            }
                        }
                }
                
                // change search bar placeholder
                if lecturerTabSelected {
                    TextField("search for a lecturer", text: $searchKey)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                        .foregroundColor(UniChatColor.lightBrown)
                }
                
                // clear inputs button
                Button {
                    searchKey = ""
                } label: {
                    Image(systemName: "x.circle.fill")
                }
                .foregroundColor(UniChatColor.brown)
                .padding(.trailing, 5)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(UniChatColor.brown)
                    .foregroundColor(.black.opacity(0))
            )
            .padding(5)
            .background(UniChatColor.headerYellow)
    
            // list of unis
            if uniTabSelected {
                ScrollView() {
                    ForEach(unis, id:\.self) { uni in
                        NavigationLink (destination: ProfileDetailsView(profileID: uni.name, profileName: uni.name, uniImage: uniImages[uni.webPages[0]] ?? URL(string: "http://www.rmit.edu.au//etc.clientlibs/rmit/clientlibs/clientlib-site/resources/favicon.png")!, profileType: "uni")) {
                            HStack {
                                VStack (spacing: 0) {
                                    // uni title
                                    Text(uni.name)
                                        .font(.headline)
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.top, 10)
                                        .padding(.bottom, 5)
                                        .padding(.horizontal, 10)
                                        .foregroundColor(.primary)
                                    
                                    // uni URL
                                    Text(uni.webPages[0])
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.bottom, 15)
                                        .padding(.horizontal, 10)
                                        .foregroundColor(.primary)
                                    
                                    // uni state
                                    Text("📍\(uni.state ?? "---")")
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.bottom, 10)
                                        .padding(.horizontal, 10)
                                        .foregroundColor(.primary)
                                    
                                    // uni rating
                                    if let uniRating = uniRatings.first(where: {$0.id == uni.name}) {
                                        let rating = Helper().ratingToStars(rating: uniRating.overview)
                                        
                                        Text(rating)
                                            .multilineTextAlignment(.leading)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.bottom, 10)
                                            .padding(.horizontal, 10)
                                            .foregroundColor(.primary)
                                    }
                                }
                                
                                Spacer()

                                AsyncImage(url: uniImages[uni.webPages[0]]) { image in
                                       image
                                           .resizable()
                                           .aspectRatio(contentMode: .fit)
                                   } placeholder: {
                                       Image(systemName: "photo")
                                           .imageScale(.large)
                                           .foregroundColor(.gray)
                                   }
                                   .scaledToFill()
                                   .frame(width: 60, height: 60)
                                   .clipped()
                                   .cornerRadius(10)
                                   .padding(.trailing, 10)
                            }
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(UniChatColor.headerYellow)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                        }
                    }
                }
                .background(UniChatColor.dimmedYellow)
                .task {
                    try? await searchUnis(query: searchKey) {
                        
                    }
                    
                    for uni in unis {
                        uniImages = await fetchUniImage(dictionary: uniImages, urlString: uni.webPages[0] ) {
                            
                        }
                    }
                }
            }
            
            // list of lecturers
            if lecturerTabSelected {
                // if searchkey is empty
                if searchKey != "" {
                    ScrollView() {
                        ForEach(lecturerRatings.filter({$0.name.contains(searchKey)}), id:\.self) { lecturer in
                            if let uni = unis.first(where: {$0.name == lecturer.uni}) {
                                NavigationLink (destination: ProfileDetailsView(profileID: "\(lecturer.id)", profileName: lecturer.name, uniImage: uniImages[uni.webPages[0]] ?? URL(string: "http://www.rmit.edu.au//etc.clientlibs/rmit/clientlibs/clientlib-site/resources/favicon.png")!, profileType: "lecturer")) {
                                    listOfLecturers(lecturer: lecturer)
                                }
                            }
                        }
                    }
                    .background(UniChatColor.dimmedYellow)
                    .task {
                        loadLecturers()
                    }
                // if searchkey has inputs
                } else {
                    ScrollView() {
                        ForEach(lecturerRatings, id:\.self) { lecturer in
                            if let uni = unis.first(where: {$0.name == lecturer.uni}) {
                                NavigationLink (destination: ProfileDetailsView(profileID: "\(lecturer.id)", profileName: lecturer.name, uniImage: uniImages[uni.webPages[0]] ?? URL(string: "http://www.rmit.edu.au//etc.clientlibs/rmit/clientlibs/clientlib-site/resources/favicon.png")! ,profileType: "lecturer")) {
                                    listOfLecturers(lecturer: lecturer)
                                }
                            }
                        }
                    }
                    .background(UniChatColor.dimmedYellow)
                    .task {
                        loadLecturers()
                    }
                }
            }
        }
    }
    
    // list of lectueres based on search queries
    func listOfLecturers(lecturer: LecturerRating) -> some View {
        return HStack {
            VStack (spacing: 0) {
                
                // lecturer name
                Text("🧑‍🏫 " + lecturer.name)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 10)
                    .foregroundColor(.primary)
                
                // lecturer uni
                Text(lecturer.uni)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 15)
                    .padding(.horizontal, 10)
                    .foregroundColor(.primary)
                
                // lecturer rating
                if let lecturerRating = lecturerRatings.first(where: {$0.name == lecturer.name}) {
                    let rating = Helper().ratingToStars(rating: lecturerRating.overview)
                    
                    Text(rating)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                        .padding(.horizontal, 10)
                        .foregroundColor(.primary)
                }
            }
            
            Spacer()

            if let uni = unis.first(where: {$0.name == lecturer.uni}) {
                AsyncImage(url: uniImages[uni.webPages[0]]) { image in
                       image
                           .resizable()
                           .aspectRatio(contentMode: .fit)
                   } placeholder: {
                       Image(systemName: "photo")
                           .imageScale(.large)
                           .foregroundColor(.gray)
                   }
                   .scaledToFill()
                   .frame(width: 60, height: 60)
                   .clipped()
                   .cornerRadius(10)
                   .padding(.trailing, 10)
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(UniChatColor.headerYellow)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
    }
    
    // fetch list of australian university
    func searchUnis(query: String = "", completionHandler: @escaping () -> Void) async throws {
        let url = URL(string: "http://universities.hipolabs.com/search?country=Australia&name=\(query)")!

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()

        let unisResult = try decoder.decode([UniversityData].self, from: data)

        self.unis = unisResult
        
        // load data into ratings if first visit
        if uniRatings.count == 0 {
            for uni in unis {
                let newRating = UniRating(context: context)
                newRating.id = uni.name
                newRating.food = 0.0
                newRating.friendliness = 0.0
                newRating.overview = 0.0
                newRating.practicality = 0.0
                
                try! context.save()
            }
        }
        completionHandler()
    }
    
    // stores data into core data if first visit
    func loadLecturers() {
        if lecturerRatings.count == 0 {
            for index in 0..<lecturersData.count {
                let newRating = LecturerRating(context: context)
                newRating.id = UUID()
                newRating.fun = 0.0
                newRating.name = lecturersData.getLecturerByIndex(index: index).name
                newRating.overview = 0.0
                newRating.strictness = 0.0
                newRating.workload = 0.0
                newRating.uni = lecturersData.getLecturerByIndex(index: index).uni
                
                try! context.save()
            }
        }
    }
    
    // get a webpage's favicon for university's logo
    func fetchUniImage(dictionary: [String: URL], urlString: String, completionHandler: @escaping () -> Void) async -> [String: URL] {
        
        var returnDictionary = dictionary
        
        do {
            let url = URL(string: urlString)
            let favicon = try await FaviconFinder(url: url!).downloadFavicon()
            
            returnDictionary[urlString] = favicon.url
            
        } catch let error {
            print("Error: \(error)")
        }
        completionHandler()
        
        return returnDictionary
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
