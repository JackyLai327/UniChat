//
//  VerifiedUni.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/10/6.
//

import Foundation
import CoreData

// verified uni for a user
@objc(VerifiedUni)
public class VerifiedUni: NSManagedObject {
    @NSManaged public var name: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<VerifiedUni> {
        return NSFetchRequest<VerifiedUni>(entityName: "VerifiedUni")
    }
}
