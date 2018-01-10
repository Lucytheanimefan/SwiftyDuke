              //
//  SDCurriculum.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 12/31/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import UIKit

class SDCurriculum: NSObject {
    
    static let shared = SDCurriculum()
    //let requestor = SDRequester(baseURL: SDConstants.URL.streamer)

    public func getCoursesForSubject(subject:String, accessToken:String, completion:@escaping ([[String:Any]]) -> Void)
    {
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint: "curriculum/courses/subject/\(subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)?access_token=\(accessToken)", headers: nil, body: nil) { (response) in
            
            if let json = response as? [String:Any]{
                if let resp = json["ssr_get_courses_resp"] as? [String:Any]{
                    if let searchResult = resp["course_search_result"] as? [String:Any]{
                        if let subjects = searchResult["subjects"] as? [String:Any]{
                            if let subject = subjects["subject"] as? [String:Any]{
                                if let courseSummaries = subject["course_summaries"] as? [String:Any]{
                                    if let courseSummary = courseSummaries["course_summary"] as? [[String:Any]]{
                                      completion(courseSummary)
                                    }
                                }
                            }
                        }
                    }
                }
                //completion(json)
            }
        }
    }
}
