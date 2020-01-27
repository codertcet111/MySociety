//
//  ChangeMemberPositionViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ChangeMemberPositionViewController: UIViewController {

    let nc = NotificationCenter.default
    var selectedMemberId: Int = 0
    var selectedMemberName: String = ""
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
        nc.addObserver(self, selector: #selector(updateSelectedMemberLabels), name: Notification.Name.selectUserMemberPopOverDismissNC, object: nil)
    }
    
    @objc func updateSelectedMemberLabels(){
        self.selectMemberButton.setTitle("\(selectMemberSharedFile.shared.memberSelectedName)", for: .normal)
    }

}
