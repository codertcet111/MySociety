//
//  logInUserViewController.swift
//  MySociety
//
//  Created by Admin on 17/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class logInUserViewController: UIViewController {

    @IBOutlet weak var mySocietyImageView: UIImageView!
    
    @IBOutlet weak var mySocietyImageTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var LogInBtn: UIButton!
    @IBAction func logInBtnAction(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogInBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        self.mySocietyImageTopConstraints.constant = 400
        self.mySocietyImageTopConstraints.constant = 40
        UIView.animate(withDuration: 1.5, animations: {
            self.view.layoutIfNeeded()
        })
    }

}
