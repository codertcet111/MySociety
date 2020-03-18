//
//  RegisterInExistingSocietyViewController.swift
//  MySociety
//
//  Created by Admin on 17/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class RegisterInExistingSocietyViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainviewheightConstraints: NSLayoutConstraint!
    
    @IBAction func passwordDIdEnd(_ sender: Any) {
//        self.view.endEditing(true)
//        self.mainviewheightConstraints.constant = 900
//        self.view.layoutIfNeeded()
    }
    @IBAction func passwordChanged(_ sender: Any) {
//        self.mainviewheightConstraints.constant = 1100
//        self.view.layoutIfNeeded()
    }
    @IBAction func passwordBegin(_ sender: Any) {
//        self.mainviewheightConstraints.constant = 1100
//        self.view.layoutIfNeeded()
    }
    @IBAction func mobileEnd(_ sender: Any) {
//        self.view.endEditing(true)
//        self.mainviewheightConstraints.constant = 900
//        self.view.layoutIfNeeded()
    }
    @IBAction func mobileChanged(_ sender: Any) {
//        self.mainviewheightConstraints.constant = 1100
//        self.view.layoutIfNeeded()
    }
    @IBAction func mobileBegin(_ sender: Any) {
//        self.mainviewheightConstraints.constant = 1100
//        self.view.layoutIfNeeded()
    }
    @IBAction func emailend(_ sender: Any) {
//        self.view.endEditing(true)
//        self.mainviewheightConstraints.constant = 900
//        self.view.layoutIfNeeded()
    }
    @IBAction func emailchanged(_ sender: Any) {
//        self.mainviewheightConstraints.constant = 1100
//        self.view.layoutIfNeeded()
    }
    @IBAction func emailbegin(_ sender: Any) {
//        self.mainviewheightConstraints.constant = 1100
//        self.view.layoutIfNeeded()
    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        self.mainviewheightConstraints.constant = 900
//        self.view.layoutIfNeeded()
//        return false
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardListeners()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        NotificationCenter.default.removeObserver(self)
    }

    func addKeyboardListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        // Do something here.
        self.mainviewheightConstraints.constant = 1050
        self.view.layoutIfNeeded()
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        // Do something here.
        self.mainviewheightConstraints.constant = 850
        self.view.layoutIfNeeded()
    }
    
    
    
    let nc = NotificationCenter.default
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
    var rolesArray = ["Secretary", "Treasurer", "Chairman", "Member"]
    var selectedRoleIndex: Int = 0 //0:Secretory, 1:Treasurer, 2:Chairman, 3:Simple Member
        
    func checkAndValidateFieldBfrRegister() -> Bool{
        if selectSocietyBtn.title(for: .normal) == "Select Society"{
            showAlert("Please Select Society ")
            return false
        }else if selectYourMemberBtn.title(for: .normal) == "Role"{
            showAlert("Please select Position ")
            return false
        }else if nameTextField.text == ""{
            showAlert("Please Type Full Name ")
            return false
        }else if flatNoTextField.text == ""{
            showAlert("Please Type Flat No ")
            return false
        }else if flatAreaTextField.text == ""{
            showAlert("Please Type flat area ")
            return false
        }else if priceSqFtTextField.text == ""{
            showAlert("Please Type price sq ft ")
            return false
        }else if userNameTextField.text == ""{
            showAlert("Please create user name ")
            return false
        }else if passwordTextField.text == ""{
            showAlert("Please create password ")
            return false
        }else if mobileTextField.text == ""{
            showAlert("Please Type mobile number ")
            return false
        }else{
            return true
        }
    }
    
    func saveRegisterAction(){
        self.showSpinner(onView: self.view)
            let parameters = [
                "society_id": "\(self.selectedSocietyId)",
                "User_position": "\(self.rolesArray[self.selectedRoleIndex])",
                "User_full_name": "\(self.nameTextField.text ?? "")",
                "User_flat_no": "\(self.flatNoTextField.text ?? "")",
                "User_wing": "\(self.wingTextField.text ?? "")",
                "User_flat_total_area": "\(self.flatAreaTextField.text ?? "")",
                "price_per_sq_ft": "\(self.priceSqFtTextField.text ?? "")",
                "User_name": "\(self.userNameTextField.text ?? "")",
                "Password": "\(self.passwordTextField.text ?? "")",
                "Mobile_number": "\(self.mobileTextField.text ?? "")",
                "Email_id": "\(self.emailTextField.text ?? "")",
                "position_type": "\(self.selectedRoleIndex)"
                ] as [String : Any]
        let headerValues = ["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"]
            let request = getRequestUrlWithHeader(url: "user-register/1", method: "POST", header: headerValues, bodyParams: parameters)
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
                                let isAdmin = (json?.value(forKey: "is_admin") as? Bool ?? true)
                                UserDefaults.standard.set(userId, forKey: loggedInUserIdDefaultKeyName)
                                UserDefaults.standard.set(isAdmin, forKey: loggedInUserIsAdminDefaultKeyName)
                                //Set Default parameters and loggingin user
                                //redirect to home page
                                loggedInUserId = UserDefaults.standard.integer(forKey: loggedInUserIdDefaultKeyName)
                                isAdminLoggedIn = isAdmin
                                
                                
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
    
    @IBOutlet weak var registerInExistingSocietyTopConstraints: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectSocietyBtn.layer.cornerRadius = 10
        selectSocietyBtnAction.layer.cornerRadius = 10
        selectYourMemberBtn.layer.cornerRadius = 10
        registerBtn.layer.cornerRadius = 10
        
        // Do any additional setup after loading the view.
//        self.registerInExistingSocietyTopConstraints.constant = 400
        self.registerInExistingSocietyTopConstraints.constant = 24
//        UIView.animate(withDuration: 1.5, animations: {
//            self.view.layoutIfNeeded()
//        })
        self.selectSocietyBtn.setTitle("Select Society", for: .normal)
        self.selectYourMemberBtn.setTitle("Role", for: .normal)
        nc.addObserver(self, selector: #selector(updateSelectedSocietyLabels), name: Notification.Name.selectSocietyPopOverDismissNC, object: nil)
        setView()
    }
    
    func setView(){
        self.scrollView.keyboardDismissMode = .interactive
        self.passwordTextField.delegate = self
        self.mobileTextField.delegate = self
        self.emailTextField.delegate = self
        self.selectSocietyBtn.dropShadow()
        self.selectYourMemberBtn.dropShadow()
        self.nameTextField.dropShadow()
        self.flatAreaTextField.dropShadow()
        self.flatNoTextField.dropShadow()
        self.wingTextField.dropShadow()
        self.priceSqFtTextField.dropShadow()
        self.userNameTextField.dropShadow()
        self.passwordTextField.dropShadow()
        self.mobileTextField.dropShadow()
        self.emailTextField.dropShadow()
    }
    
    @objc func updateSelectedSocietyLabels(){
        self.selectSocietyBtn.setTitle("\(selectSocietySharedFile.shared.societySelectedName)", for: .normal)
        self.selectedSocietyId = selectSocietySharedFile.shared.societySelectedId
    }

}
