//
//  OutlineTableViewCell.swift
//  DemoApp
//
//  Created by Lucy Zhang on 1/10/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit

class OutlineTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    private var _children = [String]()
    var children:[String]{
        set{
            self._children = newValue
        }
        get{
            return self._children
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
