//
//  IdentityViewController.swift
//  DemoApp
//
//  Created by Lucy Zhang on 1/10/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit
import SwiftyDuke

class IdentityViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    private var _searchActive:Bool = false
    var searchActive:Bool! {
        get {
            return self._searchActive
        }
        
        set {
            self._searchActive = newValue
            self.tableView.reloadData()
        }
    }
    
    var searchResults = [[String:Any]]()
    var filtered = [[String:Any]]()
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadIdentities(query:String){
        SDIdentityManager.shared.searchPeopleDirectory(queryTerm: query, accessToken: SDConstants.Values.testToken) { (identities) in
            self.searchResults = identities
            self.filtered = identities
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func search(_ sender: UIButton) {
        loadIdentities(query: self.searchField.text!)
    }
    
}

extension IdentityViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tmpFiltered = (searchActive) ? filtered : searchResults
        return tmpFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identityCellID") as! CourseTableViewCell
        
        let tmpFiltered = (searchActive) ? filtered : searchResults
        
        guard indexPath.row <= tmpFiltered.count else {
            return cell
        }
        
        cell.label.text = (tmpFiltered[indexPath.row]["display_name"]) as? String
        return cell
    }
    
    
}

extension IdentityViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filtered = self.searchResults.filter({ (identityObject) -> Bool in
            var toInclude:Bool = false
            let displayName = identityObject["display_name"] as? NSString
            let netid = identityObject["netid"] as? NSString
            var email:NSString! = ""
            if let emails = identityObject["emails"] as? [NSString]
            {
                email = emails[0]
            }
            let name = identityObject["givenName"] as? NSString
            let toSearch = [displayName, netid, email, name]
            
            for string in toSearch{
                if let str = string{
                    let range = str.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                    toInclude = (range.location != NSNotFound)
                    if (toInclude){
                        break
                    }
                }
            }
            return toInclude
        })
        
        searchActive = (filtered.count > 0)
        
        //sself.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        setSearchInactive()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        setSearchInactive()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        setSearchInactive()
    }
    
    func setSearchInactive(){
        searchActive = false;
        //self.filtered = self.searchResults
    }
}

extension IdentityViewController: UISearchBarDelegate{
    
}

