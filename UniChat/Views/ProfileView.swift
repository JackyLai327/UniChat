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
        ScrollView() {
            ForEach(unis, id:\.self) { uni in
                /*@START_MENU_TOKEN@*/Text(uni.name)/*@END_MENU_TOKEN@*/
            }
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

        let unisResult = try decoder.decode([UniversityData].self, from: data)

        self.unis = unisResult

    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
