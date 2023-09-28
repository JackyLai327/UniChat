//
//  Helper.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/24.
//

import Foundation

// this class contains helper functions that can be used in multiple places in the codebase
public class Helper {
    init() {}
    
    // converts ratings (double type) into a string of moon emojis
    public func ratingToStars(rating: Double) -> String {
        var retString = ""
        
        // break up whole number and decimal parts
        let (wholeString, decimalString) = modf(rating)
        
        // convert both parts to Int type
        let whole = Int(wholeString)
        let decimal = Double(decimalString)
        
        for _ in 0..<whole {
            retString += "🌕"
        }
        
        if decimal != 0.0 {
            retString += "🌗"
        }
        
        for _ in retString.count..<5 {
            retString += "🌑"
        }
        
        return retString
    }
    
    // converts from stars to rating
    public func starsToRating(stars: String) -> Double {
        var retDouble = 0.0
        
        for index in stars.indices {
            if stars[index] == "🌕" {
                retDouble += 1.0
            }
        }
        
        return retDouble
    }
    
    // calculate new average to store in database
    public func calculateAverage(averageRating: Double, newRating: Double, count: Int) -> Double {
        var retDouble: Double = 0.0
        
        if count == 0 {
            retDouble = 0.0
        } else if count == 1 {
            retDouble = newRating
        } else {
            retDouble = (averageRating * Double(count - 1) + newRating) / Double(count)
        }
        
        return retDouble
    }
}
