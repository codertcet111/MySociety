//
//  electionResultsHomePageTableViewCell.swift
//  MySociety
//
//  Created by Admin on 10/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class electionResultsHomePageTableViewCell: UITableViewCell {

    var Id: Int = 0
    @IBOutlet weak var electionResultBackgroundView: UIView!
    
    @IBOutlet weak var electionResultResultLabel: UILabel!
    @IBOutlet weak var electionResultDescriptionLabel: UILabel!
    @IBOutlet weak var electionResultTitleLabel: UILabel!
    
    
    @IBOutlet weak var timeStampDateLabel: UILabel!
}
