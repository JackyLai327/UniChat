//
//  Notifications.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/23.
//

import Foundation
import CoreData

enum NotificationType: String {
    case like = "like"
    case reply = "reply"
    case share = "share"
}

public class Notification: NSManagedObject, Identifiable{
    @NSManaged public var discussion: String
    @NSManaged public var id: UUID
    @NSManaged public var receiver: String
    @NSManaged public var sender: String
    @NSManaged public var timestamp: Date
    @NSManaged public var typeString: String
}

extension Notification {
    var notificationType: NotificationType {
        get {
            return NotificationType(rawValue: String(typeString)) ?? .like
        }
        
        set {
            self.typeString = String(newValue.rawValue)
        }
    }
}
