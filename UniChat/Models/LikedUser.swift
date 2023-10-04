//
//  Like.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/6.
//

import Foundation
import CoreData

@objc(LikedUser)
public class LikedUser: NSManagedObject {
    @NSManaged public var username: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedUser> {
        return NSFetchRequest<LikedUser>(entityName: "LikedUser")
    }
}
