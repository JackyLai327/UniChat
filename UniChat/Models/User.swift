//
//  User.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/6.
//

import Foundation
import CoreData

// user object from core data
@objc (User)
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

    @objc(addVerifiedUniObject:)
    @NSManaged public func addToVerifiedUni(_ value: VerifiedUni)

    @objc(removeVerifiedUniObject:)
    @NSManaged public func removeVerifiedUni(_ value: VerifiedUni)

    @objc(addVerifiedUni:)
    @NSManaged public func addToVerifiedUni(_ values: NSSet)

    @objc(removeVerifiedUni:)
    @NSManaged public func removeVerifiedUni(_ values: NSSet)

}
