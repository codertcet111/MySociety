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
    var rolesArray = ["Secretary", "Chairman", "Treasurer"]
    var selectedRole: Int = 0
    @IBOutlet weak var selectMemberTitleLabel: UILabel!
    @IBOutlet weak var selectMemberButton: UIButton!
    
    @IBAction func selectMemberAction(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var selectPositionTitleLabel: UILabel!
    
    @IBOutlet weak var selectPositionBtn: UIButton!
    
    @IBAction func selectPositionAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Select Role", message: nil, preferredStyle: .alert)
        
        let closure = { (action: UIAlertAction!) -> Void in
            self.selectPositionBtn.setTitle(action.title, for: .normal)
            self.selectedRole = self.rolesArray.firstIndex(where: {$0 == action.title}) ?? 0
        }
        for tempRole in rolesArray {
            alert.addAction(UIAlertAction(title: tempRole, style: .default, handler: closure))
        }
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: {(_) in }))
        self.present(alert, animated: false, completion: nil)
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
