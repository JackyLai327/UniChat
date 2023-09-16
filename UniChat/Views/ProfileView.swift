//
//  ProfileView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/22.
//

import SwiftUI

struct ProfileView: View {
    
    @State var unis = [UniversityData]()
    
    var body: some View {
        VStack() {
            Text("omg")
        }
        .task {
            try! await searchUnis()
        }
    }
    
    // fetch list of australian university
    func searchUnis() async throws {
        let url = URL(string: "http://universities.hipolabs.com/search?country=Australia")!

        let (data, URLResponse) = try await URLSession.shared.data(from: url)
        print(URLResponse)

        let decoder = JSONDecoder()

        let unisResult = try decoder.decode([UniversityDataSearchResult].self, from: data)

//        self.unis = unisResult.results

    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
