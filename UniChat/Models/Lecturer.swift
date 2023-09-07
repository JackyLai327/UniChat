//
//  Lecturer.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/7.
//

import Foundation
import CoreData

public class Lecturer: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var overview: Double
    @NSManaged public var strictness: Double
    @NSManaged public var fun: Double
    @NSManaged public var workload: Double
}
