//
//  RegisterInExistingSocietyViewController.swift
//  MySociety
//
//  Created by Admin on 17/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class RegisterInExistingSocietyViewController: UIViewController {

    @IBOutlet weak var selectSocietyTitleLabel: UILabel!
    @IBOutlet weak var selectSocietyTitleTopConstraints: UIView!
    @IBOutlet weak var selectSocietyBtn: UIButton!
    
    @IBOutlet weak var selectSocietyBtnAction: UIButton!
    @IBOutlet weak var selectYourMemberBtn: UIButton!
    @IBAction func selectPositionAction(_ sender: UIButton) {
        
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var flatNoTextField: UITextField!
    @IBOutlet weak var wingTextField: UITextField!
    
    @IBOutlet weak var flatAreaTextField: UITextField!
    @IBOutlet weak var priceSqFtTextField: UITextField!
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBAction func registerBtnAction(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
