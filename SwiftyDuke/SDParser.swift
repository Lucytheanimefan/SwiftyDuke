//
//  SDParser.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 12/31/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import UIKit

class SDParser: NSObject {
    
    class func textInString(filterTerm:String, text:NSString) -> Bool{
        let range = text.range(of: filterTerm, options: NSString.CompareOptions.caseInsensitive)
        return (range.location != NSNotFound)
    }

}
