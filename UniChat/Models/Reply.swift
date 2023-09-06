//
//  Notifications.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/23.
//

import Foundation
import CoreData

public class Reply: NSManagedObject, Identifiable {
    @NSManaged public var content: String
    @NSManaged public var discussion: String
    @NSManaged public var id: UUID
    @NSManaged public var numUps: Int32
    @NSManaged public var timestamp: Date
    @NSManaged public var username: String
}
