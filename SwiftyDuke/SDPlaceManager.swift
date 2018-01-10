//
//  SDPlacemanager.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 1/10/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit

class SDPlaceManager: NSObject {
    
    static let shared = SDPlaceManager()
    
    public func getPlaceCategories(accessToken:String, completion:@escaping ([[String:Any]]) -> Void){
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint: "places/categories?access_token=\(accessToken)", headers: nil, body: nil) { (response) in
            if let json = response as? [[String:Any]]{
                completion(json)
            }
        }
    }
    
    public func placeForTag(tag:String, accessToken:String, completion:@escaping ([[String:Any]]) -> Void){
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint: "places/items?tag=\(tag)&access_token=\(accessToken)", headers: nil, body: nil) { (response) in
            if let json = response as? [[String:Any]]{
                completion(json)
//                json.forEach({ (dict) in
//                    let place = SDPlace(id: dict["place_id"], name: dict["name"], locationName: dict["location"], longitude: <#T##Double#>, latitude: <#T##Double#>, googleMapLink: <#T##String?#>, tags: <#T##[String]?#>, phoneNumber: <#T##String?#>, open: <#T##Bool?#>)
//                })
            }
        }
    }
    
    public func placeForID(id:String, accessToken:String, completion:@escaping ([String:Any]) -> Void){
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint: "places/items/index?place_id=\(id)&access_token=\(accessToken)", headers: nil, body: nil) { (response) in
            if let json = response as? [String:Any]{
                completion(json)
            }
        }
        
    }

}
