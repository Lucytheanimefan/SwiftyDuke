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
    
    var clientID:String!
    var clientSecret:String!
    
    init(clientID:String, clientSecret:String) {
        super.init()
        self.clientID = clientID
        self.clientSecret = clientSecret
    }
    
    public func netIDIdentity(completion:@escaping ([String:Any]) -> Void){
        // TODO
        SDRequester.shared.makeHTTPRequest(method: "GET", endpoint: "identity/v1?client_id=\(self.clientID!)&client_secret=\(self.clientSecret!)", headers: ["X-API-Key":""],body: nil, completion: completion as! (Any) -> Void)
        
    }

}
