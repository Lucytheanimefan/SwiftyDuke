//
//  SocialViewController.swift
//  DemoApp
//
//  Created by Teddy Marchildon on 2/5/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit
import SwiftyDuke

class SocialViewController: UITableViewController {

    var posts: [[String:Any]]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSocialInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getSocialInfo() {
        let alertController = self.presentLoadingIndicator()
        SDSocial.shared.getSocial(accessToken: SDConstants.Values.testToken, error: { (message) in
            alertController.removeLoadingIndicator()
            alertController.title = "Authentication error"
            alertController.message = message
            alertController.addDismissalButton()
        }, completion: { (result) in
            self.dismiss(animated: false, completion: nil)
            self.posts = result
        })
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let posts = self.posts else {
            return tableView.dequeueReusableCell(withIdentifier: "socialTableViewCell")!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "socialTableViewCell", for: indexPath)
        let index = indexPath.row
        let post = posts[index]
        let sdPost = SDSocialPost(post: post)
        cell.textLabel?.text = sdPost.title
        if sdPost.socialMediaType == .Facebook {
            cell.tintColor = .blue
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let posts = self.posts else {
            return 0
        }
        return posts.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
