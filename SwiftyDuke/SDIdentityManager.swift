//
//  SDIdentity.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 12/9/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import UIKit
import os.log
public class SDIdentityManager: NSObject {
    
    public static let shared = SDIdentityManager()
    
    public func personForNetID(netID:String,accessToken:String, error:@escaping (String) -> Void, completion:@escaping (_ result:[String:Any], _ error:String) -> Void){
        
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint: "ldap/people/netid/\(netID)?access_token=\(accessToken)", body: nil, completion: completion as! ([String : Any]?, String?) -> Void)
        
    }
    
    public func personForUniqueID(uniqueID:String,accessToken:String, error:@escaping (String) -> Void, completion:@escaping (_ result:[String:Any], _ error:String) -> Void){
        
        
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint:"ldap/people/duid/\(uniqueID)?access_token=\(accessToken)", body: nil, completion: completion as! ([String : Any]?, String?) -> Void)
    }
    
    public func searchPeopleDirectory(queryTerm:String, accessToken:String, error:@escaping (String) -> Void, completion:@escaping (_ result:[String:Any], _ error:String) -> Void){
        
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint:"ldap/people?q=\(queryTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&access_token=\(accessToken)", body: nil, completion: completion as! ([String : Any]?, String?) -> Void)
    }

}
