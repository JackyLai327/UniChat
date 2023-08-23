//
//  Notifications.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/23.
//

import Foundation

struct Notification: Codable, Identifiable {
    
    enum CodingKeys: CodingKey {
        case sender
        case receiver
        case type
        case discussion
        case timestamp
    }
    
    var id = UUID()
    var sender: String
    var receiver: String
    var type: String
    var discussion: String
    var timestamp: Date
}

class ReadNotifications: ObservableObject {
    @Published var notifications = [Notification]()
    
    init() {
        loadNotifications()
    }
    
    func loadNotifications() {
        guard let url = Bundle.main.url(forResource: "NotificationsData", withExtension: "json")
            else {
                print("JSON file not fuond")
                return
            }
        
        let data = try? Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let notifications = try? decoder.decode([Notification].self, from: data!)
        self.notifications = notifications!
    }
}
