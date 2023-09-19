//
//  Like.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/6.
//

import Foundation
import CoreData

// FIXME: do i really need  this class ?
public class LikedUser: NSManagedObject, Identifiable {
    @NSManaged public var sender: String
    @NSManaged public var receiver: String
    @NSManaged public var id: UUID
    @NSManaged public var timestamp: Date
}
