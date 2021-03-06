//
//  nytimes_ios_mostpopularTests.swift
//  nytimes-ios-mostpopularTests
//
//  Created by Jeraldo Abille on 7/2/18.
//  Copyright © 2018 thejeraldo. All rights reserved.
//

import XCTest
import Alamofire
@testable import nytimes_ios_mostpopular

class nytimes_ios_mostpopularTests: XCTestCase {
  
  let baseURL = "https://api.nytimes.com"
  let apiKey = "5bcd7c7c9bf746089afa6924facf90d9"
  
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  func testSectionsAPI() {
    let expectations = XCTestExpectation(description: "sections api")
    let service = NYTimesService()
    service.getSections { (sections, error) in
      XCTAssertNil(error, "Sections api error")
      XCTAssertNotNil(sections, "Sections was nil")
      expectations.fulfill()
    }
    
    wait(for: [ expectations ], timeout: 60)
  }
  
  func testMostPopulaAPI() {
    let expectations = XCTestExpectation(description: "mostpopular api")
    let service = NYTimesService()
    service.getMostPopularForSection("all-sections", timePeriod: .day) { (mostPopular, error) in
      XCTAssertNil(error, "MostPopular api error")
      XCTAssertNil(mostPopular?.message, "MostPopular api error \(mostPopular?.message ?? "")")
      XCTAssertNotNil(mostPopular, "MostPopular was nil")
      expectations.fulfill()
    }
    
    wait(for: [ expectations ], timeout: 60)
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
