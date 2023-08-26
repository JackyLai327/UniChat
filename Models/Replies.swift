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
    
    // load all replies on init
    init() {
        loadReplies()
    }
    
    /* Load Replies
     * Read from json file and transfer json strings into objects
     * @param: no params
     * @return: no returns
     */
    func loadReplies() {
        
        // Try to read from specified file name, otherwise print JSON not found
        guard let url = Bundle.main.url(forResource: "RepliesData", withExtension: "json")
            else {
                print("JSON file not fuond")
                return
            }
        
        let data = try? Data(contentsOf: url)
        
        // Set up docoder to unwrap iso.8601 datetime format properly
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        // Convert JSON objects into swift objects
        let notifications = try? decoder.decode([Reply].self, from: data!)
        self.replies = notifications!
    }
}
