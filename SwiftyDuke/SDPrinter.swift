//
//  SDPrinter.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 4/10/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit

class SDPrinter: NSObject {
    
    static let shared = SDPrinter()
    
    public func get3dPrinters(error: @escaping (String) -> Void, completion:@escaping ([[String:Any]]) -> Void){
        SDRequester.colab.makeHTTPRequest(method: "GET", endpoint: "3dprinters/v1/printers", headers: ["x-api-key": "api-docs"], body: nil, error: {(message) in
            error(message)
        }, completion: { (response) in
            guard let json = response as? [[String:Any]] else {
                error("Data for 3d printers")
                return
            }
            completion(json)
        })
    }

}
