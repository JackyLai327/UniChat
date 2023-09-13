//
//  Discussions.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/23.
//

import Foundation
import CoreData
import UIKit

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
}
