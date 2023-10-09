//
//  UniversityData.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/16.
//

import Foundation

/// University data object from API JSON response
struct UniversityData: Codable, Hashable {
    var state: String?
    var name: String
    var webPages: [String]
    
    enum CodingKeys: String, CodingKey {
        case state = "state-province"
        case name
        case webPages = "web_pages"
    }
}

