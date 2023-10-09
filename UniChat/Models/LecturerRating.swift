//
//  Lecturer.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/7.
//

import Foundation
import CoreData
import SwiftUI

/// Lecturer object from core data
public class LecturerRating: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var overview: Double
    @NSManaged public var strictness: Double
    @NSManaged public var fun: Double
    @NSManaged public var workload: Double
    @NSManaged public var uni: String
    @NSManaged public var numRatings: Int
}

struct Lecturer: Codable {
    
    enum CodingKeys: CodingKey {
        case name
        case uni
    }
    
    var name: String
    var uni: String
}

class ReadLecturers: ObservableObject {
    @Published var lecturers = [Lecturer]()
    var count:Int = 0
    
    init() {
        loadLecturers()
    }
    
    func loadLecturers() {
        guard let url = Bundle.main.url(forResource: "LecturerList", withExtension: "json")
            else {
                print("JSON file not fuond")
                return
            }
    
        let data = try? Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let lecturers = try? decoder.decode([Lecturer].self, from: data!)
         
        self.lecturers = lecturers!
        
        // update count
        for _ in 0..<self.lecturers.count {
            self.count += 1
        }
    }
    
    // returns the lecturer by index
    public func getLecturerByIndex(index: Int) -> Lecturer {
        return self.lecturers[index]
    }
    
    // returns list of lecturers by query
    public func searchLecturers(query: String = "") -> [Lecturer] {
        return self.lecturers.filter({$0.name.contains(query)})
    }
}
