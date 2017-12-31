//
//  SDCurriculum.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 12/31/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import UIKit

class SDCurriculum: NSObject {

    public func getCurriculumForSubject(subject:String, completion:@escaping ([[String:Any]]) -> Void)
    {
        SDRequester.shared.makeHTTPRequest(method: "GET", endpoint: "/curriculum/courses/subject/\(subject)", headers: nil, body: nil) { (response) in
            if let json = response as? [[String:Any]]{
                completion(json)
            }
        }
    }
}
