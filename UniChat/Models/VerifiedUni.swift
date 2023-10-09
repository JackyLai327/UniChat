//
//  VerifiedUni.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/10/6.
//

import Foundation
import CoreData

@objc(VerifiedUni)
/// Verified uni for a user
public class VerifiedUni: NSManagedObject {
    @NSManaged public var name: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<VerifiedUni> {
        return NSFetchRequest<VerifiedUni>(entityName: "VerifiedUni")
    }
}
