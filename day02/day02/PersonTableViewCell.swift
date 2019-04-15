//
//  PersonTableViewCell.swift
//  day02
//
//  Created by Kateryna KOSTRUBOVA on 4/4/19.
//  Copyright © 2019 Kateryna KOSTRUBOVA. All rights reserved.
//

import UIKit
import Foundation

class PersonTableViewCell: UITableViewCell {

    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var descrLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var person : (String, String, String)? {
        didSet{
            if let p = person {
                yearLabel?.text = String(p.2)
                nameLabel?.text = p.0
                descrLabel?.text = p.1
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
