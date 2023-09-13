//
//  Image.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/6.
//

import Foundation
import CoreData
import UIKit

public class DiscussionImage: NSManagedObject, Identifiable {
    @NSManaged public var discussion: String
    @NSManaged public var image: UIImage
    @NSManaged public var timestamp: Date
    @NSManaged public var id: UUID
}
