//
//  SDIdentity.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 12/9/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import UIKit
import os.log
public class SDIdentity: NSObject {
    
    static let shared = SDIdentity()
    
    public func personForNetID(netID:String,accessToken:String, completion:@escaping ([String:Any]) -> Void){
        
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint: "ldap/people/netid/\(netID)?access_token=\(accessToken)", headers: nil, body: nil) { (response) in
            if let json = response as? [[String:Any]]{
                completion(json[0])
            }
        }
        
    }
    
    public func personForUniqueID(uniqueID:String,accessToken:String,completion:@escaping ([String:Any]) -> Void){
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint: "ldap/people/duid/\(uniqueID)?access_token=\(accessToken)", headers: nil, body: nil) { (response) in
  
            if let json = response as? [String:Any]{
                completion(json)
            }
        }
    }
    
    public func searchPeopleDirectory(queryTerm:String, accessToken:String, completion:@escaping ([[String:Any]]) -> Void){
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint:  "ldap/people?q=\(queryTerm)&access_token=\(accessToken)", headers: nil, body: nil) { (response) in
            if let json = response as? [[String:Any]]{
                completion(json)
            }
        }
    }

}
