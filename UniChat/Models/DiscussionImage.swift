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
public class DiscussionImage: NSManagedObject, Identifiable {
    @NSManaged public var discussion: String
    @NSManaged public var image: UIImage
    @NSManaged public var timestamp: Date
    @NSManaged public var id: UUID
}
