//
//  ProfileView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/22.
//

import SwiftUI
import FaviconFinder

struct ProfileView: View {
    
    // fetched data is stored in an array of University Data object
    @State var unis = [UniversityData]()
    
    // fetched images will be stored into this dictionary
    @State var uniImages: [String: URL] = [:]
    
    // for searching universities
    @State var searchKey: String = ""
    
    // for tab selection
    @State var uniTabSelected = true
    @State var lecturerTabSelected = false
    
    var body: some View {
        VStack(spacing: 0) {
            HeadingView(title: "Profiles")
            
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
                                try! await searchUnis(query: searchKey)
                            }
                        }
                }
                
                if lecturerTabSelected {
                    TextField("search for a lecturer", text: $searchKey)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                        .foregroundColor(UniChatColor.lightBrown)
                        .onChange(of: searchKey) { newValue in
                            Task {
                                try! await searchUnis(query: searchKey)
                            }
                        }
                }
                
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
                        NavigationLink (destination: ProfileDetailsView()) {
                            HStack {
                                VStack (spacing: 0) {
                                    Text(uni.name)
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.bottom, 5)
                                        .padding(.horizontal, 10)
                                        .foregroundColor(.black)
                                    
                                    Text(uni.webPages[0])
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.bottom, 15)
                                        .padding(.horizontal, 10)
                                        .foregroundColor(.black)
                                    
                                    Text("📍\(uni.state ?? "---")")
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.bottom, 5)
                                        .padding(.horizontal, 10)
                                        .foregroundColor(.black)
                                }
                                
                                Spacer()
                                
                                ForEach(uni.webPages, id: \.self) { webPage in
                                    AsyncImage(url: uniImages[webPage])
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipped()
                                        .cornerRadius(10)
                                        .padding(.trailing, 10)
                                }
                            }
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                        }
                    }
                }
                .background(UniChatColor.dimmedYellow)
                .task {
                    try! await searchUnis(query: searchKey)
                    for uni in unis {
                        await fetchUniImage(dictionary: &uniImages, urlString: uni.webPages[0] )
                    }
                }
            }
            
            // list of lecturers
            if lecturerTabSelected {
                ScrollView {
                    
                }
            }
        }
    }
    
    // fetch list of australian university
    func searchUnis(query: String = "") async throws {
        let url = URL(string: "http://universities.hipolabs.com/search?country=Australia&name=\(query)")!

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()

        let unisResult = try decoder.decode([UniversityData].self, from: data)

        self.unis = unisResult

    }
    
    // get a webpage's favicon for university's logo
    func fetchUniImage(dictionary: inout [String: URL], urlString: String) async {
        
        do {
            let url = URL(string: urlString)
            let favicon = try await FaviconFinder(url: url!).downloadFavicon()
            
            dictionary[urlString] = favicon.url
            
        } catch let error {
            print("Error: \(error)")
        }
    }
}

// preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
