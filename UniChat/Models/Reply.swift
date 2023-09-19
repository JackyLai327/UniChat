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
    @NSManaged public var upUser: NSSet?
    
    public var upUserArray: [User] {
        let set = upUser as? Set<User> ?? []
        return set.sorted {$0.username < $1.username}
    }
}

extension Reply {

    @objc(addUserObject:)
    @NSManaged public func addToUpUser(_ value: User)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUpUser(_ value: User)

    @objc(addUser:)
    @NSManaged public func addToUpUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUpUser(_ values: NSSet)

}
