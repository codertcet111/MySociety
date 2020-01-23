//
//  NewNoticeViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class NewNoticeViewController: UIViewController {

    
    @IBOutlet weak var newNoticeSetTitleTextField: UITextField!
    @IBOutlet weak var selectTimeLAbel: UILabel!
    @IBOutlet weak var newNoticeSelectImageBtn: UIButton!
    
    @IBOutlet weak var newNoticeSaveBtn: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var NewNoticeDatePicker: UIDatePicker!
    @IBOutlet weak var setTitleTextTopConstraints: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }
    
    func setView(){
        newNoticeSaveBtn.layer.cornerRadius = 10
        newNoticeSelectImageBtn.layer.cornerRadius = 10
        setTitleTextTopConstraints.constant = 500
        setTitleTextTopConstraints.constant = 45
        
        newNoticeSetTitleTextField.alpha = 0
        selectTimeLAbel.alpha = 0
        newNoticeSelectImageBtn.alpha = 0
        newNoticeSaveBtn.alpha = 0
        descriptionTextField.alpha = 0
        NewNoticeDatePicker.alpha = 0
        
        newNoticeSetTitleTextField.alpha = 1
        selectTimeLAbel.alpha = 1
        newNoticeSelectImageBtn.alpha = 1
        newNoticeSaveBtn.alpha = 1
        descriptionTextField.alpha = 1
        NewNoticeDatePicker.alpha = 1
        
        UIView.animate(withDuration: 1.5, animations: {
            self.view.layoutIfNeeded()
        })
        
    }

}
