//
//  SearchResult.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/16.
//

import Foundation

struct SearchResult<T: Decodable>: Decodable {
    let data: T
}
