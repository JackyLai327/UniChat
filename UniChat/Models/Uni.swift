//
//  Uni.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/7.
//

import Foundation
import CoreData

// uni object from core data
public class Uni: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var state: String
    @NSManaged public var overview: Double
    @NSManaged public var practicalty: Double
    @NSManaged public var food: Double
    @NSManaged public var friendliness: Double
}
