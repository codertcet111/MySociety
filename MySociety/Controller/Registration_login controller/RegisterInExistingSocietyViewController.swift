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
        let alert = UIAlertController(title: "Select Role", message: nil, preferredStyle: .alert)
        
        let closure = { (action: UIAlertAction!) -> Void in
            self.selectYourMemberBtn.setTitle(action.title, for: .normal)
            self.selectedRoleIndex = self.rolesArray.firstIndex(where: {$0 == action.title}) ?? 0
        }
        for tempRole in rolesArray {
            alert.addAction(UIAlertAction(title: tempRole, style: .default, handler: closure))
        }
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: {(_) in }))
        self.present(alert, animated: false, completion: nil)
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
       if checkAndValidateFieldBfrRegister(){
            self.saveRegisterAction()
        }
    }
    
    var selectedSocietyId: Int = 0
    var selectedSocietyName: String = ""
    var rolesArray = ["Secretary", "Treasurer", "Chairman", "Simple Member"]
    var selectedRoleIndex: Int = 0 //0:Secretory, 1:Treasurer, 2:Chairman, 3:Simple Member
        
    func checkAndValidateFieldBfrRegister() -> Bool{
        if selectSocietyBtn.title(for: .normal) == "Select Society"{
            showAlert("Please Select Society 🙁🙁")
            return false
        }else if selectYourMemberBtn.title(for: .normal) == "Role"{
            showAlert("Please select Position 🙁🙁")
            return false
        }else if nameTextField.text == ""{
            showAlert("Please Type Full Name 🙁🙁")
            return false
        }else if flatNoTextField.text == ""{
            showAlert("Please Type Flat No 🙁🙁")
            return false
        }else if flatAreaTextField.text == ""{
            showAlert("Please Type flat area 🙁🙁")
            return false
        }else if priceSqFtTextField.text == ""{
            showAlert("Please Type price sq ft 🙁🙁")
            return false
        }else if userNameTextField.text == ""{
            showAlert("Please create user name 🙁🙁")
            return false
        }else if passwordTextField.text == ""{
            showAlert("Please create password 🙁🙁")
            return false
        }else if mobileTextField.text == ""{
            showAlert("Please Type mobile number 🙁🙁")
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
    
    @IBOutlet weak var registerInExistingSocietyTopConstraints: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectSocietyBtn.layer.cornerRadius = 10
        selectSocietyBtnAction.layer.cornerRadius = 10
        selectYourMemberBtn.layer.cornerRadius = 10
        registerBtn.layer.cornerRadius = 10
        
        // Do any additional setup after loading the view.
        self.registerInExistingSocietyTopConstraints.constant = 400
        self.registerInExistingSocietyTopConstraints.constant = 40
        UIView.animate(withDuration: 1.5, animations: {
            self.view.layoutIfNeeded()
        })
        self.selectSocietyBtn.setTitle("Select Society", for: .normal)
        self.selectYourMemberBtn.setTitle("Role", for: .normal)
    }

}
