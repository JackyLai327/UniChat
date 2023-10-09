//
//  Discussions.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/23.
//

import Foundation
import CoreData
import UIKit

@objc(Discussion)
/// Discussion object from core data.
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
    @NSManaged public var discussionImage: String?
    
    // users that have liked this discussion will be stored in this likedUserArray
    public var likedUserArray: [LikedUser] {
        let set = likedUser as? Set<LikedUser> ?? []
        return set.sorted {$0.username < $1.username}
    }
}

// methods of editing the likedUserArray
extension Discussion {

    /// Adds a LikedUser object to the LikedUserArray.
    /// - Parameter value: The LikedUser object to be added to the array.
    @objc(addLikedUserObject:)
    @NSManaged public func addToLikedUser(_ value: LikedUser)

    /// Removes a LikedUser object from the LikedUserArray.
    /// - Parameter value: The LikedUser object to be removed from the array.
    @objc(removeLikedUserObject:)
    @NSManaged public func removeFromLikedUser(_ value: LikedUser)

    /// Adds an NSSet object of LikedUsers to the array.
    /// - Parameter value: The NSSet object of LikedUser to be added to the array.
    @objc(addLikedUser:)
    @NSManaged public func addToLikedUser(_ values: NSSet)

    /// Removes an NSSet object of LikedUsers from the array.
    /// - Parameter value: The NSset object of LikedUser to be removed from the array.
    @objc(removeLikedUser:)
    @NSManaged public func removeFromLikedUser(_ values: NSSet)

}
