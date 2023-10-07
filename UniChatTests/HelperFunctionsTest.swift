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
    
    
}
