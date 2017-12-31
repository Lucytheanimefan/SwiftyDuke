//
//  SDSocial.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 12/21/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import UIKit

public class SDSocial: NSObject {
    
    let requestor = SDRequester(baseURL: SDConstants.URL.streamer)
    
    static let shared = SDSocial()
    
    public func getSocial(accessToken:String, completion:@escaping ([[String:Any]]) -> Void){
        
        self.requestor.makeHTTPRequest(method: "GET", endpoint: "social/messages?access_token=\(accessToken)", headers: nil, body: nil) { (response) in
            
            if let json = response as? [[String:Any]]{
                completion(json)
            }
        }
    }
    
    public func filterSocial(accessToken:String, completion:@escaping ([[String:Any]]) -> Void, filterTerm:String?)
    {
        self.getSocial(accessToken: accessToken) { (social) in
            let filtered = social.filter({ (socialMessage) -> Bool in
                var toInclude:Bool = false
                
                if (filterTerm != nil)
                {
                    if let title = socialMessage["title"] as? NSString, let body = socialMessage["body"] as? NSString
                    {
                        toInclude = SDParser.textInString(filterTerm: filterTerm!, text: title) || SDParser.textInString(filterTerm: filterTerm!, text: body)
                    }
                }
                else
                {
                    toInclude = true
                }
                return toInclude
            })
            
            completion(filtered)
        }
    }
    
    

}
