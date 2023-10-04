//
//  Notifications.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/23.
//

import Foundation
import CoreData

// Reply object from core data
@objc(Reply)
public class Reply: NSManagedObject, Identifiable {
    @NSManaged public var content: String
    @NSManaged public var discussion: String
    @NSManaged public var id: UUID
    @NSManaged public var numUps: Int32
    @NSManaged public var timestamp: Date
    @NSManaged public var username: String
    @NSManaged public var upUser: NSSet?
    
    // users that have up'ed this reply will be stored in this upUserArray
    public var upUserArray: [UpUser] {
        let set = upUser as? Set<UpUser> ?? []
        return set.sorted {$0.username < $1.username}
    }
}

// methods of editing the upUserArray
extension Reply {

    @objc(addUpUserObject:)
    @NSManaged public func addToUpUser(_ value: UpUser)

    @objc(removeUpUserObject:)
    @NSManaged public func removeFromUpUser(_ value: UpUser)

    @objc(addUpUser:)
    @NSManaged public func addToUpUser(_ values: NSSet)

    @objc(removeUpUser:)
    @NSManaged public func removeFromUpUser(_ values: NSSet)

}
