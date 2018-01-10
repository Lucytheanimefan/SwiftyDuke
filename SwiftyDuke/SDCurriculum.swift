              //
//  SDCurriculum.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 12/31/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import UIKit

public class SDCurriculum: NSObject {
    
    public static let shared = SDCurriculum()
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
    
    public func offeringDetailsForCourse(id:String, offerNumber:String, accessToken:String, completion:@escaping ([String:Any]) -> Void){
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint: "curriculum/courses/crse_id/\(id)/crse_offer_nbr/\(offerNumber)?access_token=\(accessToken)", headers: nil, body: nil) { (response) in
            if let json = response as? [String:Any]{
                if let resp = json["ssr_get_course_offering_resp"] as? [String:Any]{
                    if let result = resp["course_offering_result"] as? [String:Any]{
                        if let offering = result["course_offering"] as? [String:Any]{
                            completion(offering)
                        }
                    }
                }
            }
        }
    }
    
    public func curriculumValues(field:String, accessToken:String, completion:@escaping ([[String:Any]]) -> Void){
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint: "curriculum/list_of_values/fieldname/\(field)?access_token=\(accessToken)", headers: nil, body: nil) { (response) in
            if let json = response as? [String:Any]{
                if let resp = json["scc_lov_resp"] as? [String:Any]{
                    if let lovs = resp["lovs"] as? [String:Any]{
                        if let lov = lovs["lov"] as? [String:Any]{
                            if let values = lov["values"] as? [String:Any]{
                                if let value = values["value"] as? [[String:Any]]{
                                    completion(value)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
