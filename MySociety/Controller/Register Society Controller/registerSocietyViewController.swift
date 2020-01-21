//
//  registerSocietyViewController.swift
//  MySociety
//
//  Created by Admin on 17/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class registerSocietyViewController: UIViewController {

    @IBOutlet weak var societyNameTitleLabel: UILabel!
    @IBOutlet weak var societyNameTitleTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var societyNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var adminNameTextField: UITextField!
    @IBOutlet weak var flatnumberTextField: UITextField!
    
    @IBOutlet weak var societyRegistrationNumber: UITextField!
    @IBOutlet weak var selectYourRoleBtn: UIButton!
    
    @IBAction func selectYourRoleAction(_ sender: UIButton) {
        
    }
    @IBOutlet weak var flatAreaTextField: UITextField!
    @IBOutlet weak var pricePerSqFtTextField: UITextField!
    
    @IBOutlet weak var wingTextField: UITextField!
    @IBOutlet weak var adminUsernameTextField: UITextField!
    @IBOutlet weak var adminPasswordTextField: UITextField!
    @IBOutlet weak var adminMobileNumber: UITextField!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var registerButtn: UIButton!
    @IBAction func registerBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func flatAreaTectField(_ sender: Any) {
        
    }
    
    @IBAction func pricePrSqFttextFiuedl(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectYourRoleBtn.layer.cornerRadius = 10
        registerButtn.layer.cornerRadius = 10
        self.societyNameTitleTopConstraints.constant = 400
        self.societyNameTitleTopConstraints.constant = 40
        UIView.animate(withDuration: 1.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    
}
