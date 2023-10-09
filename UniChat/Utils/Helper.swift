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
    
    /// Converts ratings (double type) into a string of moon emojis.
    /// Each point gets converted to a moon.
    /// Decimal points get converted into one half moon.
    /// Fill out the rest of the stars string with shaded moons.
    /// - Parameter rating: The decimal representation of rating of a uni/lecturer
    /// - Returns: The stars representation of a rating
    public func ratingToStars(rating: Double) -> String {
        var retString = ""
        
        // return with no stars for invalid rating values
        if rating < 0.0 || rating > 5.0 {
            return "🌑🌑🌑🌑🌑"
        }
        
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
    
    /// Converts from stars to rating.
    /// 1 full moon = 1 point.
    /// 1 half moon = 0.5 point.
    /// 1 shaded moon = 0.0 point.
    /// - Parameter stars: The star string represented by different shades of moons
    /// - Returns: The rating converted from the stars values
    public func starsToRating(stars: String) -> Double {
        var retDouble = 0.0
        
        // return 0.0 for invalid star values
        if stars.count != 5 {
            return retDouble
        }
        
        for index in stars.indices {
            if stars[index] == "🌕" {
                retDouble += 1.0
            }
        }
        
        return retDouble
    }
    
    /// Calculates new average rating to store in database.
    /// - Parameter averageRating: The average rating stored in core data
    /// - Parameter newRating: The new rating provided by user
    /// - Parameter count: The amount of ratings that was stored in the database
    /// - Returns: The new calculated average
    public func calculateAverage(averageRating: Double, newRating: Double, count: Int) -> Double {
        var retDouble: Double = 0.0
        
        // return original average value if invalid inputs are received
        if newRating < 0.0 || newRating > 5.0 {
            return averageRating
        }
        
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
