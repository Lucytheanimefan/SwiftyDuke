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
        
        self.requestor.makeHTTPRequest(method: "GET", endpoint: "social/messages?access_token=\(accessToken)", headers: nil, body: nil, completion: completion as! (Any) -> Void)
    }

}
