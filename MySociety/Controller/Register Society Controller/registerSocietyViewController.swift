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
    
    var rolesArray = ["Secretary", "Treasurer", "Chairman"]
    var selectedRole: Int = 0
    
    @IBAction func selectYourRoleAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Select Role", message: nil, preferredStyle: .alert)
        
        let closure = { (action: UIAlertAction!) -> Void in
            self.selectYourRoleBtn.setTitle(action.title, for: .normal)
            self.selectedRole = self.rolesArray.firstIndex(where: {$0 == action.title}) ?? 0
        }
        for tempRole in rolesArray {
            alert.addAction(UIAlertAction(title: tempRole, style: .default, handler: closure))
        }
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: {(_) in }))
        self.present(alert, animated: false, completion: nil)
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
        if checkAndValidateFieldBfrRegister(){
            self.saveRegisterAction()
        }
    }
    
    func checkAndValidateFieldBfrRegister() -> Bool{
        if societyNameTextField.text == ""{
            showAlert("Please Type Society Name 🙁🙁")
            return false
        }else if societyRegistrationNumber.text == ""{
            showAlert("Please Type Society Registration Number 🙁🙁")
            return false
        }else if selectYourRoleBtn.title(for: .normal) == "Role"{
            showAlert("Please Select Role 🙁🙁")
            return false
        }else if addressTextField.text == ""{
            showAlert("Please Type Society Address 🙁🙁")
            return false
        }else if cityTextField.text == ""{
            showAlert("Please Type City 🙁🙁")
            return false
        }else if adminNameTextField.text == ""{
            showAlert("Please Type Your Name 🙁🙁")
            return false
        }else if flatnumberTextField.text == ""{
            showAlert("Please Type Flat Number 🙁🙁")
            return false
        }else if flatAreaTextField.text == ""{
            showAlert("Please Type FLat Area 🙁🙁")
            return false
        }else if pricePerSqFtTextField.text == ""{
            showAlert("Please Type Price Per sq ft 🙁🙁")
            return false
        }else if adminUsernameTextField.text == ""{
            showAlert("Please Create Username for U 🙁🙁")
            return false
        }else if adminPasswordTextField.text == ""{
            showAlert("Please Create Password for U 🙁🙁")
            return false
        }else if adminMobileNumber.text == ""{
            showAlert("Please Type Mobile Number 🙁🙁")
            return false
        }else{
            return true
        }
    }
    
    func saveRegisterAction(){
        showAlert("Successfully!!")
    }
    
    func showAlert(_ message: String) -> (){
        let alert = UIAlertController(title: message, message: nil , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
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
        self.selectYourRoleBtn.setTitle("Role", for: .normal)
    }
    
    
}
