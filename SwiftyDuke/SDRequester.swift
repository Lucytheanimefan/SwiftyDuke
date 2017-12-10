//
//  SDRequester.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 12/9/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import UIKit
import os.log

class SDRequester: NSObject {
    var baseURL:String!
    
    static let shared = SDRequester(baseURL: "https://api.colab.duke.edu/meta/v1/apis/")
    
    init(baseURL:String) {
        super.init()
        self.baseURL = baseURL
    }
    
    func makeHTTPRequest(method:String, endpoint: String, boundary: String, body: Data, completion:@escaping (_ result:[String:Any]) -> Void) {
        #if DEBUG
            os_log("%@: Make Request: %@, %@", self.description, method, self.baseURL + endpoint)
        #endif
        
        let request = NSMutableURLRequest(url: NSURL(string: self.baseURL + endpoint)! as URL)
        request.httpMethod = method
        request.httpBody = body
        
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        executeHTTPRequest(request: request as URLRequest, completion: completion)
    }
    
    func makeHTTPRequest(method:String, endpoint: String, body: [String: Any]?, completion:@escaping (_ result:[String:Any]) -> Void) {
        #if DEBUG
            os_log("%@: Make Request: %@, %@", self.description, method, self.baseURL + endpoint)
        #endif
        
        if let url = URL(string: self.baseURL + endpoint)
        {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = method
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if (body != nil)
        {
            request.httpBody = try! JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        executeHTTPRequest(request: request as URLRequest, completion: completion)
        }
        else
        {
            os_log("%@: URL %@ is null", self.description, self.baseURL + endpoint)
        }
        
    }
    
    private func executeHTTPRequest(request: URLRequest, completion:@escaping (_ result:[String:Any]) -> Void, errorHandler:@escaping (_ result:[String:Any]) -> Void =  { error in
        if let errorDescription = error["error"] as? String
        {
            os_log("Error making http request: %@", errorDescription)
        }
        }) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            if (data != nil)
            {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]{
                        completion(json)
                    }
                }
                catch
                {
                    os_log("%@: Error serializing json: %@, Trying as string.", self.description, error.localizedDescription)
                    if let dataString = String(data:data!, encoding:.utf8)
                    {
                        errorHandler(["error":dataString])
                    }
                    else
                    {
                        os_log("%@: Could not format data as string", self.description)
                    }
                }
                //completion(data!)
            }
            else if (error != nil)
            {
                errorHandler(["error":error.debugDescription])
                #if DEBUG
                    os_log("%@: Error: %@", self.description, error.debugDescription)
                #endif
            }
        })
        task.resume()
    }
}
