//
//  CurriculumViewController.swift
//  DemoApp
//
//  Created by Lucy Zhang on 1/10/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit
import SwiftyDuke
class CurriculumViewController: UIViewController {

    @IBOutlet weak var subjectField: UITextField!
    @IBOutlet var fieldDropDown: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedSubjectField:String! = ""
    var selectedCourseTitle:String! = ""
    var selectedCourseID:String! = ""
    var selectedCourseOfferNumber:String! = ""
    var subjectFields = [String]()
    var filteredSubjectFields = [String]()
    
    var searchActive:Bool! = false
    
    var courses = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCurriculumFields()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.subjectField.resignFirstResponder()
    }
    
    
    
    func loadCurriculum(){
        SDCurriculum.shared.getCoursesForSubject(subject: self.selectedSubjectField, accessToken: SDConstants.Values.testToken) { (classes) in
            self.courses = classes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func loadCurriculumFields(){
        SDCurriculum.shared.curriculumValues(field: SDConstants.CurriculumField.subject, accessToken: SDConstants.Values.testToken) { (fields) in
            self.subjectFields = fields.map({ (json) -> String in
                return "\(json["code"] as! String) - \(json["desc"] as! String)"
            })
            DispatchQueue.main.async {
                self.fieldDropDown.reloadAllComponents()
            }
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let vc = segue.destination as? CourseViewController{

            vc.courseTitle = self.selectedCourseTitle
            vc.courseID = self.selectedCourseID
            vc.courseOfferNumber = self.selectedCourseOfferNumber
        }
    }
    

}

extension CurriculumViewController: UITableViewDelegate, UITableViewDataSource{
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courses.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCellID", for: indexPath) as! CourseTableViewCell
        
        let course = self.courses[indexPath.row]
        var title:String = ""
        if let titleLong = course["course_title_long"] as? String{
            title = titleLong
        }
        let courseNumber = course["catalog_nbr"] as! String
        
        cell.label.text = "\(courseNumber): \(title)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = self.courses[indexPath.row]
        self.selectedCourseTitle = course["course_title_long"] as? String
        self.selectedCourseID = course["crse_id"] as! String
        self.selectedCourseOfferNumber = course["crse_offer_nbr"] as! String
        
        performSegue(withIdentifier: "courseSegue", sender: self)

    }
}

extension CurriculumViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let tmpFields = searchActive ? self.filteredSubjectFields : self.subjectFields
        return tmpFields.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let tmpFields = searchActive ? self.filteredSubjectFields : self.subjectFields
        
        guard tmpFields.count >= row else {
            return nil
        }
        return tmpFields[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let tmpFields = searchActive ? self.filteredSubjectFields : self.subjectFields
        self.selectedSubjectField = tmpFields[row]
        self.subjectField.text = self.selectedSubjectField
        loadCurriculum()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchActive = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchActive = false
    }
  
    
    @IBAction func subjectFieldChanged(_ sender: UITextField) {
        let filterTerm = sender.text
        
        guard filterTerm != nil && (filterTerm!.count > 0) else {
            searchActive = false
            self.fieldDropDown.reloadAllComponents()
            return
        }
        
        self.filteredSubjectFields = self.subjectFields.filter({ (field) -> Bool in

            let include = SDParser.textInString(filterTerm: filterTerm!, text: field as NSString)

            return include
            
        })
        
        self.fieldDropDown.reloadAllComponents()
    }
    

}