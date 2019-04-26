//
//  VisitCell.swift
//  COP4655GroupProject
//
//  Created by Nathaniel Pulido on 4/25/19.
//  Copyright © 2019 kpuli007. All rights reserved.
//

import UIKit

class VisitCell: UITableViewCell {
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeInLabel: UILabel!
    @IBOutlet var timeOutLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateLabel.adjustsFontForContentSizeCategory = true
        timeInLabel.adjustsFontForContentSizeCategory = true
        timeOutLabel.adjustsFontForContentSizeCategory = true
    }
    
}
