//
//  Uni.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/7.
//

import Foundation
import CoreData

/// Uni object from core data
public class UniRating: NSManagedObject, Identifiable {
    @NSManaged public var id: String
    @NSManaged public var overview: Double
    @NSManaged public var practicality: Double
    @NSManaged public var food: Double
    @NSManaged public var friendliness: Double
    @NSManaged public var numRatings: Int
}
