//
//  User.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/6.
//

import Foundation
import CoreData

@objc (User)
/// User object from core data.
public class User: NSManagedObject {
    @NSManaged public var username: String
    @NSManaged public var password: String
    @NSManaged public var verifiedUni: NSSet?
    
    // array of unis verified for this user
    public var verifiedUnis: [VerifiedUni] {
        let set = verifiedUni as? Set<VerifiedUni> ?? []
        return set.sorted {$0.name < $1.name}
    }
}

// methods of editing the upUserArray
extension User {
    
    /// Adds a VerifiedUni object to the VerifiedUniArray.
    /// - Parameter value: The VerifiedUni object to be added to the array.
    @objc(addVerifiedUniObject:)
    @NSManaged public func addToVerifiedUni(_ value: VerifiedUni)

    /// Removes a VerifiedUni object from the VerifiedUniArray.
    /// - Parameter value: The VerifiedUni object to be removed from the array.
    @objc(removeVerifiedUniObject:)
    @NSManaged public func removeVerifiedUni(_ value: VerifiedUni)

    /// Adds an NSSet object of VerifiedUni to the array.
    /// - Parameter value: The NSSet object of VerifiedUni to be added to the array.
    @objc(addVerifiedUni:)
    @NSManaged public func addToVerifiedUni(_ values: NSSet)

    /// Removes an NSSet object of VerifiedUni from the array.
    /// - Parameter value: The NSset object of VerifiedUni to be removed from the array.
    @objc(removeVerifiedUni:)
    @NSManaged public func removeVerifiedUni(_ values: NSSet)

}
