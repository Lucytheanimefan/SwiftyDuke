//
//  SDAuthenticator.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 12/21/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import UIKit
import os.log

class SDAuthenticator: NSObject {
    
    static let baseURL:String = "https://oauth2.duke.edu/auth"//?response_type=code&client_id=CLIENT_ID&redirect_uri=REDIRECT_URI&scope=SCOPE
    
    let requester = SDRequester(baseURL: SDAuthenticator.baseURL)
    
    static let shared = SDAuthenticator()
    
    public func authenticate(clientID:String, redirectURI:String, scope:String, completion:@escaping ([String:Any]) -> Void){
        let endpoint = "?response_type=code&client_id=\(clientID)&scope=\(scope)&redirect_uri=\(redirectURI)"
        
        requester.makeHTTPRequest(method: "GET", endpoint: endpoint, headers: nil, body: nil) { (response) in
            os_log("%@: Response: %@", self.description, response)
            completion(response)
        }
    }

}
