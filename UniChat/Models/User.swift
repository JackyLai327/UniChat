//
//  User.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/6.
//

import Foundation
import CoreData

// user object from core data
public class User: NSManagedObject {
    @NSManaged public var username: String
    @NSManaged public var password: String
}
