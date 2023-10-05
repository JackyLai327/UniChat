//
//  Image.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/6.
//

import Foundation
import CoreData
import UIKit

// image object from core data
// FIXME: re-do this class and make images strings of URLs stored in documents
@objc(DiscussionImage)
public class DiscussionImage: NSManagedObject, Identifiable {
    @NSManaged public var image: String
    @NSManaged public var timestamp: Date
    @NSManaged public var id: UUID
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiscussionImage> {
        return NSFetchRequest<DiscussionImage>(entityName: "DiscussionImage")
    }
}
