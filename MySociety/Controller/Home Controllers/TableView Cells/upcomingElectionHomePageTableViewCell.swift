//
//  upcomingElectionHomePageTableViewCell.swift
//  MySociety
//
//  Created by Admin on 10/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class upcomingElectionHomePageTableViewCell: UITableViewCell {

    var Id: Int = 0
    @IBOutlet weak var upcomingElectionBackgroundView: UIView!
    
    @IBOutlet weak var upcomingElectionTitle: UILabel!
    @IBOutlet weak var upcomingElectionDescriptionLabel: UILabel!
    @IBOutlet weak var upcomingElectionStartDateLAbel: UILabel!
    
    @IBOutlet weak var upcomingElectionEndDateLabel: UILabel!
    @IBOutlet weak var timeStampDateLabel: UILabel!
    
}
