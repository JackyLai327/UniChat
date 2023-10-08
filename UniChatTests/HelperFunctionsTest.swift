//
//  HelperFunctionsTest.swift
//  UniChatTests
//
//  Created by Jacky Lai on 2023/10/7.
//

import Foundation
import XCTest

@testable import UniChat

class CounterViewModelTest: XCTestCase {
    
    // test valid rating value to be converted into stars
    func testRatingToStarsValidLowerBoundRating() {
        // arrange
        let helper = Helper()
        let rating = 0.0
        
        let expectedResult = "🌑🌑🌑🌑🌑"
        
        // act
        let actualResult = helper.ratingToStars(rating: rating)
        
        // assert
        XCTAssertEqual(expectedResult, actualResult)
    }
    
    // test converting valid rating value to stars
    func testRatingToStarsValidUpperBoundRating() {
        // arrange
        let helper = Helper()
        let rating = 5.0
        
        let expectedResult = "🌕🌕🌕🌕🌕"
        
        // act
        let actualResult = helper.ratingToStars(rating: rating)
        
        // assert
        XCTAssertEqual(expectedResult, actualResult)
    }
    
    // test converting invalid (out of bound) rating to stars
    func testRatingToStarsInvalidRating() {
        // arrange
        let helper = Helper()
        let rating = 5.1
        
        let expectedResult = "🌑🌑🌑🌑🌑"
        
        // act
        let actualResult = helper.ratingToStars(rating: rating)
        
        // assert
        XCTAssertEqual(expectedResult, actualResult)
    }
    
    // test converting valid lower bound star value to rating
    func testStarsToRatingValidLowerBoundStars() {
        // arrange
        let helper = Helper()
        let stars = "🌑🌑🌑🌑🌑"
        
        let expectedResult = 0.0
        
        // act
        let actualResult = helper.starsToRating(stars: stars)
        
        // assert
        XCTAssertEqual(expectedResult, actualResult)
    }
    
    // test converting valid upper bound star value to rating
    func testStarsToRatingValidUpperBoundStars() {
        // arrange
        let helper = Helper()
        let stars = "🌕🌕🌕🌕🌕"
        
        let expectedResult = 5.0
        
        // act
        let actualResult = helper.starsToRating(stars: stars)
        print(actualResult)
        
        // assert
        XCTAssertEqual(expectedResult, actualResult)
    }
    
    // test converting invalid (no stars) star value to rating
    func testStarsToRatingInvalidNoStars() {
        // arrange
        let helper = Helper()
        let stars = "STARS"
        
        let expectedResult = 0.0
        
        // act
        let actualResult = helper.starsToRating(stars: stars)
        
        // assert
        XCTAssertEqual(expectedResult, actualResult)
    }
    
    // test converting invalid (too many stars) star value to rating
    func testStarsToRatingInvalidTooManyStars() {
        // arrange
        let helper = Helper()
        let stars = "🌕🌕🌕🌕🌗🌑"
        
        let expectedResult = 0.0
        
        // act
        let actualResult = helper.starsToRating(stars: stars)
        
        // assert
        XCTAssertEqual(expectedResult, actualResult)
    }
    
    // test new average with valid upper bound new rating value
    func testCalculateAverageValidUpperBoundNewRating() {
        // arrange
        let helper = Helper()
        let averageRating = 1.0
        let newRating = 5.0
        let count = 2
        
        let expectedResult = 3.0
        
        // act
        let actualResult = helper.calculateAverage(averageRating: averageRating, newRating: newRating, count: count)
        
        // assert
        XCTAssertEqual(expectedResult, actualResult)
    }
    
    // test new average with valid lower bound new rating value
    func testCalculateAverageValidLowerBoundNewRating() {
        // arrange
        let helper = Helper()
        let averageRating = 5.0
        let newRating = 0.0
        let count = 2
        
        let expectedResult = 2.5
        
        // act
        let actualResult = helper.calculateAverage(averageRating: averageRating, newRating: newRating, count: count)
        
        // assert
        XCTAssertEqual(expectedResult, actualResult)
    }
    
    // test new average with invlaid (out of bound) value
    func testCalculateAverageInvalidOutOfBoundNewRating() {
        // arrange
        let helper = Helper()
        let averageRating = 3.5
        let newRating = 5.1
        let count = 2
        
        let expectedResult = averageRating
        
        // act
        let actualResult = helper.calculateAverage(averageRating: averageRating, newRating: newRating, count: count)
        
        // assert
        XCTAssertEqual(expectedResult, actualResult)
    }
}
