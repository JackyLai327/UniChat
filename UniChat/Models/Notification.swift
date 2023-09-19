//
//  Notifications.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/23.
//

import Foundation
import CoreData

// three types of notifications
enum NotificationType: String {
    case like = "like"
    case reply = "reply"
    case share = "share"
}

// notification object from core data
public class Notification: NSManagedObject, Identifiable{
    @NSManaged public var discussion: String
    @NSManaged public var id: UUID
    @NSManaged public var receiver: String
    @NSManaged public var sender: String
    @NSManaged public var timestamp: Date
    @NSManaged public var typeString: String
}

// notification type raw value getter and setter
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
