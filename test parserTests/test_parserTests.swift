//
//  test_parserTests.swift
//  test parserTests
//
//  Created by Mathieu Janneau on 19/06/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import XCTest
@testable import test_parser

class test_parserTests: XCTestCase {
    let betclicParser = BetclicParser()
  
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
  func testFetchingRssFromBetclic() {
    var sports = [Sport]()
    let exp = expectation(description: "populated")
    
      self.betclicParser.fetchData() { data  in
     sports = data
      exp.fulfill()
      }
    
    waitForExpectations(timeout: 10.0) { (error) in
      print(error?.localizedDescription ?? "error")
    }
    
    XCTAssert(sports.count != 0)
  }
    

    
}
