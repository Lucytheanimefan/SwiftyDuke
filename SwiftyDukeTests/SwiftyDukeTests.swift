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
    
//    func testAuth(){
//        let expect = expectation(description: "auth")
//        SDAuthenticator.shared.authenticate(clientID: "curriculum-mobile", redirectURI: "https://gitlab.oit.duke.edu/colab", scope: "basic") { (response) in
//            expect.fulfill()
//        }
//        waitForExpectations(timeout: 100) { (error) in
//            os_log("Error: %@", error.debugDescription)
//        }
//    }
    
    func testSocial(){
        let expect = expectation(description: "social")
        SDSocial.shared.getSocial(accessToken: "bd778fb524e4c197bfbfe4e56843bd90") { (response) in
            os_log("%@: Response: %@", self.description, response)
            expect.fulfill()
        }
        waitForExpectations(timeout: 100) { (error) in
            os_log("Error: %@", error.debugDescription)
        }
    }
    
    func testSocialFilter(){
        let expect = expectation(description: "social filter")
        SDSocial.shared.filterSocial(accessToken: "bd778fb524e4c197bfbfe4e56843bd90", completion: { (filtered) in
            //os_log("%@: Response: %@", self.description, filtered)
            expect.fulfill()
        }, filterTerm: "fruitcake")
        waitForExpectations(timeout: 100) { (error) in
            os_log("Error: %@", error.debugDescription)
        }
    }
    
    func testSocialSource(){
        let expect = expectation(description: "social source")
        SDSocial.shared.socialBySource(accessToken: "bd778fb524e4c197bfbfe4e56843bd90", mediaType: SDSocial.mediaType.facebook, completion: { (filtered) in
            os_log("%@: Response: %@", self.description, filtered)
            expect.fulfill()
        })
        waitForExpectations(timeout: 100) { (error) in
            os_log("Error: %@", error.debugDescription)
        }
    }
    
    func testCurriculum(){
        let expect = expectation(description: "Curriculum")
        SDCurriculum.shared.getCoursesForSubject(subject: "ECE - Electrical & Computer Egr", accessToken: "bd778fb524e4c197bfbfe4e56843bd90") { (classes) in
            os_log("%@: Curricula: %@", self.description, classes)                              
            expect.fulfill()
        }
        waitForExpectations(timeout: 30) { (error) in
            os_log("Error: %@", error.debugDescription)
        }
    }
}
