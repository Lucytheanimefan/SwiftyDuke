//
//  SocialViewController.swift
//  DemoApp
//
//  Created by Lucy Zhang on 4/10/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit
import SwiftyDuke

class SocialViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    let socialMediaColors = ["Twitter": UIColor(red: 0, green: 172/255, blue: 237/255, alpha: 1), "Facebook": UIColor(red: 109/255, green: 132/255, blue: 180/255, alpha: 1)]
    
    var posts: [[String:Any]]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        getSocialInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRefresh(_ sender: UIRefreshControl) {
        getSocialInfo(dismissView: false, dismissRefresh: true)
    }
    
    private func getSocialInfo(dismissView:Bool = true, dismissRefresh:Bool = false) {
        let alertController = self.presentLoadingIndicator()
        SDSocial.shared.getSocial(accessToken: SDConstants.Values.testToken, error: { (message) in
            alertController.removeLoadingIndicator()
            alertController.title = "Authentication error"
            alertController.message = message
            alertController.addDismissalButton()
        }, completion: { (result) in
            if (dismissView){
                self.dismiss(animated: false, completion: nil)
            }
            if (dismissRefresh){
                self.refreshControl.endRefreshing()
            }
            self.posts = result
        })
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

extension SocialViewController: UITableViewDelegate{
    
}

extension SocialViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let posts = self.posts else {
            return tableView.dequeueReusableCell(withIdentifier: "socialTableViewCell")!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "socialTableViewCell", for: indexPath)
        let index = indexPath.row
        let post = posts[index]
        
        if let title = post["title"] as? String {
            cell.textLabel?.text = title
        }
        
        if let type = post["source"] as? String {
            cell.backgroundColor = self.socialMediaColors[type]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let posts = self.posts else {
            return 0
        }
        return posts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
