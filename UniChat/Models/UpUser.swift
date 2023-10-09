//
//  UpUser.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/10/4.
//

import Foundation
import CoreData

@objc(UpUser)
/// User who ups a reply
public class UpUser: NSManagedObject {
    @NSManaged public var username: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UpUser> {
        return NSFetchRequest<UpUser>(entityName: "UpUser")
    }
}
