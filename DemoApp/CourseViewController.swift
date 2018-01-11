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
    //@IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    var course:SDCourse?
    
    var courseAttributes = [String]()
    
    var subTableViewRowCount:Int! = 0
    
    var selectedCellChildren:[String]!
    
    var selectedIndex:Int! = 0
    
    var selectedOutlineCells = [Int:Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.courseLabel.text = self.courseTitle
        
        getCourseInfo()
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
            
            // Populated selected cells with false
            for (index, _) in (self.course?.propertyNames().enumerated())!{
                self.selectedOutlineCells[index] = false
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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
        var rowCount = 0
        guard self.course != nil else{
            return rowCount
        }
        
        if (tableView.restorationIdentifier == "infoID")
        {
            rowCount = self.course!.propertyNames().count
        }
        else if (tableView.restorationIdentifier == "outlineTableViewID")
        {
            rowCount = self.subTableViewRowCount
        }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let key = self.course!.propertyNames()[indexPath.row]
        let value = self.course![key]
        var height:Int! = 35
        let selected = self.selectedOutlineCells[indexPath.row]
        if (indexPath.row == self.selectedIndex && selected!){
            if let _ = value as? [String]{
                height = 150
            }
        }
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!
        
        guard self.course != nil else{
            cell = tableView.dequeueReusableCell(withIdentifier: "courseCellID") as! CourseTableViewCell
            (cell as! CourseTableViewCell).label.text = "ERROR"
            return cell
        }
        
        let key = self.course!.propertyNames()[indexPath.row]
        
        if (tableView.restorationIdentifier == "outlineTableViewID")
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "outlineViewSubCellID") as! CourseTableViewCell
            let text = (self.selectedCellChildren != nil) ? self.selectedCellChildren[indexPath.row] : ""
            (cell as! CourseTableViewCell).label.text = text
            
        }
        else if (tableView.restorationIdentifier == "infoID")
        {
            let value = self.course![key]
            if (value is String)
            {
                cell = tableView.dequeueReusableCell(withIdentifier: "courseCellID") as! CourseTableViewCell
                (cell as! CourseTableViewCell).label.text = "\(key): \(value!)"
            }
            else if let valueArr = value as? [String]
            {
                cell = tableView.dequeueReusableCell(withIdentifier: "outlineCellID") as! OutlineTableViewCell
                (cell as! OutlineTableViewCell).label.text = key
                (cell as! OutlineTableViewCell).children = valueArr
                (cell as! OutlineTableViewCell).tableView.delegate = self
                (cell as! OutlineTableViewCell).tableView.dataSource = self
                (cell as! OutlineTableViewCell).tableView.reloadData()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard self.course != nil else{
            return
        }

        if (tableView.restorationIdentifier == "infoID")
        {
            if let cell = tableView.cellForRow(at: indexPath) as? OutlineTableViewCell{
                let key = self.course!.propertyNames()[indexPath.row]
                if let values = self.course![key] as? [String]{
                    self.subTableViewRowCount = values.count
                    self.selectedCellChildren = values
                    self.selectedIndex = indexPath.row
                    
                    let selected = selectedOutlineCells[indexPath.row]
                    self.selectedOutlineCells[indexPath.row] = (selected == nil) ? true : !selected!

                    self.tableView.reloadData()
                    cell.tableView.reloadData()
                }
            }
        }
    }
}

extension CourseViewController: OutlineTableViewDelegate{
   

}
