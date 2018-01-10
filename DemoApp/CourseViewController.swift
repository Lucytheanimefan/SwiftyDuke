//
//  CourseViewController.swift
//  DemoApp
//
//  Created by Lucy Zhang on 1/10/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit
import SwiftyDuke

class CourseViewController: UIViewController {

    var courseTitle:String! = ""
    var courseID:String!
    var courseOfferNumber:String!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    var course:SDCourse!
    
    var courseAttributes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.courseLabel.text = self.courseTitle
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCourseInfo(){
        SDCurriculum.shared.offeringDetailsForCourse(id: courseID, offerNumber: courseOfferNumber, accessToken: SDConstants.Values.testToken) { (info) in
            //self.descriptionView.text = info["descrlong"] as! String
            self.course = SDCourse(infoDict: info)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CourseViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.course.propertyNames().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "outlineCellID") as! OutlineTableViewCell
        
        let key = self.course.propertyNames()[indexPath.row]
        if let value = self.course[key] as? String
        {
            cell.label.text = "\(key): \(value)"
        }
        else if let value = self.course[key] as? [String]
        {
            cell.label.text = key
            cell.children = value
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    
    
}
