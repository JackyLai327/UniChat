//
//  Notifications.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/23.
//

import Foundation

struct Reply: Codable, Identifiable, Hashable {
    
    enum CodingKeys: CodingKey {
        case discussion
        case user
        case content
        case numUps
        case timestamp
    }
    
    var id = UUID()
    var discussion: String
    var user: String
    var content: String
    var numUps: Int
    var timestamp: Date
}

class ReadReplies: ObservableObject {
    @Published var replies = [Reply]()
    
    init() {
        loadReplies()
    }
    
    func loadReplies() {
        guard let url = Bundle.main.url(forResource: "RepliesData", withExtension: "json")
            else {
                print("JSON file not fuond")
                return
            }
        
        let data = try? Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let notifications = try? decoder.decode([Reply].self, from: data!)
        self.replies = notifications!
    }
}
