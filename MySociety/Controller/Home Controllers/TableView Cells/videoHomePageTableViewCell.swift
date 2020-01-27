//
//  videoHomePageTableViewCell.swift
//  MySociety
//
//  Created by Admin on 10/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class videoHomePageTableViewCell: UITableViewCell {

    var Id: Int = 0
    @IBOutlet weak var videoBackgroundView: UIView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var videoView: PlayerView!
    @IBOutlet weak var timeStampDateLabel: UILabel!
    @IBOutlet weak var playPauseBtn: UIButton!
    var isPlaying: Bool = false
    
}
