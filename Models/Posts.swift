//
//  Posts.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/23.
//

import Foundation
import UIKit

struct Post: Codable, Identifiable {
    
    enum CodingKeys: CodingKey {
        case user
        case target
        case content
        case numLikes
        case numReplies
        case numShares
        case replies
        case images
    }
    
    var id = UUID()
    var user: String
    var target: String
    var content: String
    var numLikes: Int
    var numReplies: Int
    var numShares: Int
    var replies: [String]
    var images: [UIImage]
}

class ReadPosts: ObservableObject {
    @Published var notifications = [Notification]()
    
    init() {
        loadPosts()
    }
    
    func loadPosts() {
        guard let url = Bundle.main.url(forResource: "PostsData", withExtension: "json")
            else {
                print("JSON file not fuond")
                return
            }
        
        let data = try? Data(contentsOf: url)
        let notifications = try? JSONDecoder().decode([Notification].self, from: data!)
        self.notifications = notifications!
    }
}
