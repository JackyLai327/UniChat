//
//  Discussions.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/23.
//

import Foundation
import CoreData
import UIKit

// discussion object from core data
@objc(Discussion)
public class Discussion: NSManagedObject, Identifiable {
    @NSManaged public var content: String
    @NSManaged public var id: UUID
    @NSManaged public var numLikes: Int32
    @NSManaged public var numReplies: Int32
    @NSManaged public var numShares: Int32
    @NSManaged public var target: String
    @NSManaged public var timestamp: Date
    @NSManaged public var username: String
    @NSManaged public var targetType: String
    @NSManaged public var likedUser: NSSet?
    
    // users that have liked this discussion will be stored in this likedUserArray
    public var likedUserArray: [LikedUser] {
        let set = likedUser as? Set<LikedUser> ?? []
        return set.sorted {$0.username < $1.username}
    }
}

// methods of editing the likedUserArray
extension Discussion {

    @objc(addLikedUserObject:)
    @NSManaged public func addToLikedUser(_ value: LikedUser)

    @objc(removeLikedUserObject:)
    @NSManaged public func removeFromLikedUser(_ value: LikedUser)

    @objc(addLikedUser:)
    @NSManaged public func addToLikedUser(_ values: NSSet)

    @objc(removeLikedUser:)
    @NSManaged public func removeFromLikedUser(_ values: NSSet)

}
