//
//  SDSocial.swift
//  SwiftyDuke
//
//  Created by Teddy Marchildon on 2/5/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

//Custom date because NSDate generally works with time intervals since 1970
public struct SDDate {
    var month: Int
    var day: Int
    var year: Int
    var time: String
    
    init() {
        self.month = 0
        self.day = 0
        self.year = 0
        self.time = ""
    }
}

public class SDSocialPost {
    public var socialMediaType: SDConstants.Media
    public var title: String
    public var body: String
    public var date: SDDate
    public var url: NSURL?
    
    public init(socialMediaType: String, title: String, body: String, date: String, url: String) {
        self.socialMediaType = (socialMediaType == "Facebook") ? SDConstants.Media.Facebook : SDConstants.Media.Twitter
        self.title = title
        self.body = body
        self.url = NSURL(string: url)
        let dateArray = date.components(separatedBy: "T")
        let dayArray = dateArray[0].components(separatedBy: "-")
        var postDate = SDDate()
        if let year = Int(dayArray[0]) {
            postDate.year = year
        }
        if let month = Int(dayArray[1]) {
            postDate.month = month
        }
        if let day = Int(dayArray[2]) {
            postDate.day = day
        }
        postDate.time = dateArray[1]
        self.date = postDate
    }
    
    public convenience init(post: [String: Any]) {
        self.init(socialMediaType: post["source"] as! String, title: post["title"] as! String, body: post["body"] as! String, date: post["date_posted"] as! String, url: post["source_url"] as! String)
    }
}
