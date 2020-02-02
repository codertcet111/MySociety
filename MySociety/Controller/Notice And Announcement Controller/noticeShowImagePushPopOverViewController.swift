//
//  noticeShowImagePushPopOverViewController.swift
//  MySociety
//
//  Created by Admin on 02/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SDWebImage

class noticeShowImagePushPopOverViewController: UIViewController {

    @IBOutlet weak var noticeImageView: UIImageView!
    @IBOutlet weak var backgroundImage: UIView!
    var tempImageUrl: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundImage.cornerRadius(radius: 10.0)

        let imageURL = URL(string: "\(self.tempImageUrl)")
        //            myImageView.contentMode = UIView.ContentMode.scaleToFill
        self.noticeImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named:"building"))
        // Do any additional setup after loading the view.
    }

}
