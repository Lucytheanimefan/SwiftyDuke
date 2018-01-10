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
    var subjectFields = [String]()
    
    var courses = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCurriculumFields()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func transitionVC(id:String){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: id)
        
        ((UIApplication.shared.delegate?.window)!)!.rootViewController = vc
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
        let title = course["course_title_long"] as! String
        let courseNumber = course["catalog_nbr"] as! String
        
        cell.label.text = "\(courseNumber): \(title)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "courseVCID") as! CourseViewController
        let course = self.courses[indexPath.row]
        vc.courseTitle = course["course_title_long"] as! String
        vc.courseID = course["crse_id"] as! String
        
        ((UIApplication.shared.delegate?.window)!)!.rootViewController = vc
    }
}

extension CurriculumViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.subjectFields.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.subjectFields[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedSubjectField = self.subjectFields[row]
        self.subjectField.text = self.selectedSubjectField
        loadCurriculum()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.fieldDropDown.isHidden = false
        
        textField.endEditing(true)
    }
}
