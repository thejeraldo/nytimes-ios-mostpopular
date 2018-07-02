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
    
    if let url = URL(string: baseURL)?.appendingPathComponent("svc/mostpopular/v2/viewed/sections.json") {
      let params: Parameters = [
        "api-key": apiKey
      ]
      Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
        guard response.error == nil else {
          expectations.fulfill()
          return
        }
        print(response)
        XCTAssert(response.value != nil, "response was nil")
        expectations.fulfill()
      }
    }
    
    wait(for: [ expectations ], timeout: 60)
  }
  
  func testMostPopulaAPI() {
    let expectations = XCTestExpectation(description: "mostpopular api")
    
    if let url = URL(string: baseURL)?.appendingPathComponent("svc/mostpopular/v2/mostviewed/all-sections/7.json") {
      let params: Parameters = [
        "api-key": apiKey
      ]
      Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
        guard response.error == nil else {
          expectations.fulfill()
          return
        }
        print(response)
        XCTAssert(response.value != nil, "response was nil")
        expectations.fulfill()
      }
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
