//
//  SDSocial.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 12/21/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import UIKit
import os.log

public class SDSocial: NSObject {
    
    //let requestor = SDRequester(baseURL: SDConstants.URL.streamer)
    
    public static let shared = SDSocial()
    
    public struct mediaType{
        static let facebook = "facebook"
        static let twitter = "twitter"
    }
    
    public func getSocial(accessToken:String, completion:@escaping (_ result:[[String:Any]], _ error:String) -> Void){
        
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint: "social/messages?access_token=\(accessToken)", body: nil, completion: completion as! ([[String : Any]]?, String?) -> Void)
        

    }
    
    public func filterSocial(accessToken:String, completion:@escaping (_ result:[String:Any]?, _ error:String?) -> Void, filterTerm:String?)
    {
        self.getSocial(accessToken: accessToken) { (result, error) in
            if let json = result as? [[String:Any]]{
                var filtered = [[String:Any]]()
                if (filterTerm != nil){
                    filtered = SDParser.filter(filterObject: json, filterTerm: filterTerm!, filterKeys: ["title", "body"])
                }
            }
            completion(filtered, error)
        }
        
        self.getSocial(accessToken: accessToken, error: { (message) in
            os_log("%@ Respone %@", message, self.description)
        }, completion: { (social) in
            var filtered:[[String:Any]]! = social
            if (filterTerm != nil){
                filtered = SDParser.filter(filterObject: social, filterTerm: filterTerm!, filterKeys: ["title", "body"])
            }
            completion(filtered)
        })
        
    }
    
    public func socialBySource(accessToken:String, mediaType:String, completion:@escaping (_ result:[String:Any], _ error:String) -> Void){
        self.getSocial(accessToken: accessToken, error: { (message) in
            os_log("%@ Respone %@", message, self.description)
        }, completion: { (social) in
            let filtered = SDParser.filter(filterObject: social, filterTerm: mediaType, filterKeys: ["source"])
            completion(filtered)
        })
    }

}
