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
    let requestor = SDRequester(baseURL: SDConstants.URL.streamer)

    public func getCurriculumForSubject(subject:String, accessToken:String, completion:@escaping ([String:Any]) -> Void)
    {
        self.requestor.makeHTTPRequest(method: "GET", endpoint: "curriculum/courses/subject/\(subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)?access_token=\(accessToken)", headers: nil, body: nil) { (response) in
            print("Curriculum response:")
            print(response)
            print(type(of:response))
            if let json = response as? [String:Any]{
                completion(json)
            }
        }
    }
}
