//
//  SDAuthenticator.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 12/21/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import UIKit
import os.log

public class SDAuthenticator: NSObject {
    
    let requester = SDRequester(baseURL: SDConstants.URL.oauth)
    
    static let shared = SDAuthenticator()
    //https://oauth.oit.duke.edu/oauth/authorize.php?response_type=token&client_id=hypotheticalmeals&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2F
    //duke_oauth%2Fcallback&scope=basic&state=7711
    //https://oauth.oit.duke.edu/oauth/authorize.php?client_id=kungfoods&client_secret=imnotputtingoursecretheredoyouthinkimdumb&redirect_uri=http%3A%2F%2Flocalhost%3A1717&response_type=token&state=1129&scope=basic
    public func authenticate(clientID:String, clientSecret:String, redirectURI:String, completion:@escaping ([String:Any]) -> Void){
        let endpoint = "authorize.php?client_id=\(clientID)&client_secret=\(clientSecret)&response_type=token&scope=basic&state=1129&redirect_uri=\(redirectURI.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
        
        requester.makeHTTPRequest(method: "GET", endpoint: endpoint, headers: nil, body: nil, error: { (message) in
            os_log("%@: Error: %@", self.description, message)
        }, completion: { (response) in
            print("Response: \(response)")
            completion(response as! [String:Any])
        })
    }
    
}
