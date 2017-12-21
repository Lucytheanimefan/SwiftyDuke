//
//  SwiftyDukeTests.swift
//  SwiftyDukeTests
//
//  Created by Lucy Zhang on 12/9/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import XCTest
@testable import SwiftyDuke
import os.log

class SwiftyDukeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
    
    //    func testNetID(){
    //        let expect = expectation(description: "netID")
    //        let SDIdent = SDIdentity.init(clientID: "curriculum-mobile", clientSecret: "##iLZ%e@z@TYPGcGb%Ho9fgr$K8k79G$xCm#ut91zI=dwv=EHC")
    //
    //        SDIdent.netIDIdentity { (result) in
    //            os_log("Result of netid: %@", result)
    //            expect.fulfill()
    //        }
    //
    //        waitForExpectations(timeout: 100) { (error) in
    //            os_log("Error: %@", error.debugDescription)
    //        }
    //    }
    
    func testAuth(){
        let expect = expectation(description: "auth")
        SDAuthenticator.shared.authenticate(clientID: "curriculum-mobile", redirectURI: "https://gitlab.oit.duke.edu/colab", scope: "basic") { (response) in
            expect.fulfill()
        }
        waitForExpectations(timeout: 100) { (error) in
            os_log("Error: %@", error.debugDescription)
        }
    }
    
}
