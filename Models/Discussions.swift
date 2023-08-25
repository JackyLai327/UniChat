//
//  Discussions.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/23.
//

import Foundation

struct Discussion: Codable {
    
    enum CodingKeys: CodingKey {
        case discussion
        case user
        case target
        case content
        case numLikes
        case usersLiked
        case numReplies
        case numShares
        case images
        case timestamp
    }
    
    var discussion: String
    var user: String
    var target: String
    var content: String
    var numLikes: Int
    var usersLiked: [String]
    var numReplies: Int
    var numShares: Int
    var images: [String]
    var timestamp: Date
}

class ReadDiscussions: ObservableObject {
    @Published var discussions = [Discussion]()
    
    init() {
        loadDiscussions()
    }
    
    func loadDiscussions() {
        guard let url = Bundle.main.url(forResource: "DiscussionsData", withExtension: "json")
            else {
                print("JSON file not fuond")
                return
            }
    
        let data = try? Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let discussions = try? decoder.decode([Discussion].self, from: data!)
        self.discussions = discussions!
    }
}
