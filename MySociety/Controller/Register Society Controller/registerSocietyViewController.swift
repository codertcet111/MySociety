//
//  registerSocietyViewController.swift
//  MySociety
//
//  Created by Admin on 17/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class registerSocietyViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var societyNameTitleLabel: UILabel!
    @IBOutlet weak var societyNameTitleTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var societyNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var adminNameTextField: UITextField!
    @IBOutlet weak var flatnumberTextField: UITextField!
    
    @IBOutlet weak var societyRegistrationNumber: UITextField!
    @IBOutlet weak var selectYourRoleBtn: UIButton!
    @IBOutlet weak var mainViewHeightConstraints: NSLayoutConstraint!
    //Above default value 1150
    @IBAction func passwordDidEndOnExitAction(_ sender: Any) {
//        self.view.endEditing(true)
//        self.mainViewHeightConstraints.constant = 1150
//        self.view.layoutIfNeeded()
    }
    @IBAction func passwordEditingChangeAction(_ sender: UITextField) {
//        self.mainViewHeightConstraints.constant = 1300
//        self.view.layoutIfNeeded()
    }
    @IBAction func passwordEditingDidBeginAction(_ sender: UITextField) {
//        self.mainViewHeightConstraints.constant = 1300
//        self.view.layoutIfNeeded()
    }

    @IBAction func mobileNumberDidEnd(_ sender: UITextField) {
//        self.view.endEditing(true)
//        self.mainViewHeightConstraints.constant = 1150
//        self.view.layoutIfNeeded()
    }
    @IBAction func mobilenumberEditingChanged(_ sender: UITextField) {
//        self.mainViewHeightConstraints.constant = 1300
//        self.view.layoutIfNeeded()
    }
    @IBAction func mbileEditingDidBegin(_ sender: UITextField) {
//        self.mainViewHeightConstraints.constant = 1300
//        self.view.layoutIfNeeded()
    }

    @IBAction func emailDidBegiin(_ sender: UITextField) {
//        self.view.endEditing(true)
//        self.mainViewHeightConstraints.constant = 1150
//        self.view.layoutIfNeeded()
    }
    @IBAction func emailEdiditingChanged(_ sender: UITextField) {
//        self.mainViewHeightConstraints.constant = 1300
//        self.view.layoutIfNeeded()
    }
    @IBAction func emailEditiingDid(_ sender: UITextField) {
//        self.mainViewHeightConstraints.constant = 1300
//        self.view.layoutIfNeeded()
    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        self.mainViewHeightConstraints.constant = 1150
//        self.view.layoutIfNeeded()
//        return false
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardListeners()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    func addKeyboardListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        // Do something here.
        self.mainViewHeightConstraints.constant = 1350
        self.view.layoutIfNeeded()
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        // Do something here.
        self.mainViewHeightConstraints.constant = 1150
        self.view.layoutIfNeeded()
    }
    
    
    var rolesArray = ["Secretary", "Chairman", "Treasurer"]
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
            showAlert("Please Type Society Name ")
            return false
        }else if societyRegistrationNumber.text == ""{
            showAlert("Please Type Society Registration Number ")
            return false
        }else if selectYourRoleBtn.title(for: .normal) == "Role"{
            showAlert("Please Select Role ")
            return false
        }else if addressTextField.text == ""{
            showAlert("Please Type Society Address ")
            return false
        }else if cityTextField.text == ""{
            showAlert("Please Type City ")
            return false
        }else if adminNameTextField.text == ""{
            showAlert("Please Type Your Name ")
            return false
        }else if flatnumberTextField.text == ""{
            showAlert("Please Type Flat Number ")
            return false
        }else if flatAreaTextField.text == ""{
            showAlert("Please Type FLat Area ")
            return false
        }else if pricePerSqFtTextField.text == ""{
            showAlert("Please Type Price Per sq ft ")
            return false
        }else if adminUsernameTextField.text == ""{
            showAlert("Please Create Username for U ")
            return false
        }else if adminPasswordTextField.text == ""{
            showAlert("Please Create Password for U ")
            return false
        }else if adminMobileNumber.text == ""{
            showAlert("Please Type Mobile Number ")
            return false
        }else{
            return true
        }
    }
    
    func saveRegisterAction(){
        self.showSpinner(onView: self.view)
            let parameters = [
                "society_name": "\(self.societyNameTextField.text ?? "")",
                "Society_registration_number": "\(self.societyRegistrationNumber.text ?? "")",
                "position": "\(self.rolesArray[self.selectedRole])",
                "Society_address": "\(addressTextField.text ?? "")",
                "Society_city": "\(self.cityTextField.text ?? "")",
                "full_name": "\(adminNameTextField.text ?? "")",
                "Flat_no": "\(flatnumberTextField.text ?? "")",
                "Wing": "\(self.wingTextField.text ?? "")",
                "User_Flat_area": "\(self.flatAreaTextField.text ?? "")",
                "User_price_per_sq_ft": "\(pricePerSqFtTextField.text ?? "")",
                "User_Name": "\(self.adminUsernameTextField.text ?? "")",
                "Password": "\(self.adminPasswordTextField.text ?? "")",
                "Mobile_number": Int(adminMobileNumber.text ?? "") ?? 0,
                "Email_id": "\(self.emailIdTextField.text ?? "")",
                "position_type": self.selectedRole
                ] as [String : Any]
        let headerValues = ["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"]
            let request = getRequestUrlWithHeader(url: "addregistersociety/1", method: "POST", header: headerValues, bodyParams: parameters)
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                DispatchQueue.main.async {
                    self.removeSpinner()
                }
                if (error != nil) {
                    print(error ?? "")
                } else {
                    let httpResponse = response as? HTTPURLResponse
                    let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Body: \(String(describing: strData))")
                    let json: NSDictionary?
                    do {
                        if data != nil{
                            json = try JSONSerialization.jsonObject(with: Data(data!), options: .allowFragments) as? NSDictionary
                        }else{
                            json = nil
                        }
                    } catch let dataError {
                        // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
                        print("**********")
                        print(dataError)
                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                        print("Error could not parse JSON: '\(String(describing: jsonStr))'")
                        self.showToast(message : "Some Error has occured, try after!", fontSize: CGFloat(15))
                        // return or throw?
                        return
                    }
                    if(response != nil && data != nil){
                        switch  httpResponse?.statusCode ?? 204 {
                        case 200:
                            DispatchQueue.main.sync {
                                let userId = (json?.value(forKey: "user_id") as? Int ?? 0)
                                UserDefaults.standard.set(userId, forKey: loggedInUserIdDefaultKeyName)
                                UserDefaults.standard.set(true, forKey: loggedInUserIsAdminDefaultKeyName)
                                //Set Default parameters and loggingin user
                                //redirect to home page
                                loggedInUserId = UserDefaults.standard.integer(forKey: loggedInUserIdDefaultKeyName)
                                isAdminLoggedIn = true
                                
                                
                                let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                                let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "tabBarControllerViewController")
                                appDelegate.window?.rootViewController = initialViewController
                                appDelegate.window?.makeKeyAndVisible()
                            }
                        case 401:
                            DispatchQueue.main.sync {
                                self.showToast(message: "Unathorized", fontSize: 14.0)
                            }
                        default:
                            DispatchQueue.main.sync {
                                self.showToast(message: "Something went wrong", fontSize: 14.0)
                            }
                        }
                    }
                }
            })
            
            dataTask.resume()
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
//        self.societyNameTitleTopConstraints.constant = 400
        self.societyNameTitleTopConstraints.constant = 24
//        UIView.animate(withDuration: 1.5, animations: {
//            self.view.layoutIfNeeded()
//        })
//        self.emailIdTextField.delegate = self
//        self.adminMobileNumber.delegate = self
//        self.adminPasswordTextField.delegate = self
        self.selectYourRoleBtn.setTitle("Role", for: .normal)
        self.setView()
    }
    
    func setView(){
        scrollView.keyboardDismissMode = .interactive
        self.societyNameTextField.dropShadow()
        self.societyRegistrationNumber.dropShadow()
        self.addressTextField.dropShadow()
        self.cityTextField.dropShadow()
        self.adminNameTextField.dropShadow()
        self.flatnumberTextField.dropShadow()
        self.wingTextField.dropShadow()
        self.flatAreaTextField.dropShadow()
        self.pricePerSqFtTextField.dropShadow()
        self.adminUsernameTextField.dropShadow()
        self.adminPasswordTextField.dropShadow()
        self.adminMobileNumber.dropShadow()
        self.emailIdTextField.dropShadow()
        self.selectYourRoleBtn.dropShadow()
    }
    
    
}
