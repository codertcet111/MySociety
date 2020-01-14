//
//  ChangeMemberPositionViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ChangeMemberPositionViewController: UIViewController {

    @IBOutlet weak var selectMemberTitleLabel: UILabel!
    @IBOutlet weak var selectMemberButton: UIButton!
    
    @IBAction func selectMemberAction(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var selectPositionTitleLabel: UILabel!
    
    @IBOutlet weak var selectPositionBtn: UIButton!
    
    @IBAction func selectPositionAction(_ sender: UIButton) {
    }
    
    @IBOutlet weak var updateButton: UIButton!
    
    @IBAction func updateAction(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectPositionBtn.layer.cornerRadius = 10
        self.updateButton.layer.cornerRadius = 10
        self.selectMemberButton.layer.cornerRadius  = 10
        // Do any additional setup after loading the view.
    }
    

}
