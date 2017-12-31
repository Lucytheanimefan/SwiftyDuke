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
    
    public struct mediaType{
        static let facebook = "facebook"
        static let twitter = "twitter"
    }
    
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
            var filtered:[[String:Any]]! = social
            if (filterTerm != nil){
                filtered = SDParser.filter(filterObject: social, filterTerm: filterTerm!, filterKeys: ["title", "body"])
            }
            completion(filtered)
        }
        
    }
    
    public func socialBySource(accessToken:String, mediaType:String,completion:@escaping ([[String:Any]]) -> Void){
        self.getSocial(accessToken: accessToken) { (social) in
            let filtered = SDParser.filter(filterObject: social, filterTerm: mediaType, filterKeys: ["source"])
            completion(filtered)
        }
    }
    
    

}
