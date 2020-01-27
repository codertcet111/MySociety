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
        if self.checkAndValidateFields(){
            self.logINUserRequest()
        }
    }
    
    func checkAndValidateFields() -> Bool{
        if userNameTextField.text == ""{
            showAlert("Please Enter User Name ")
            return false
        }else if passwordTextField.text == ""{
            showAlert("Please Enter Password ")
            return false
        }else{
            return true
        }
    }
    
    func logINUserRequest(){
        UserDefaults.standard.set(2, forKey: loggedInUserIdDefaultKeyName)
        UserDefaults.standard.set(true, forKey: loggedInUserIsAdminDefaultKeyName)
        //Set Default parameters and loggingin user
        //redirect to home page
        loggedInUserId = UserDefaults.standard.integer(forKey: loggedInUserIdDefaultKeyName)
        isAdminLoggedIn = true
        
        
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "tabBarControllerViewController")
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
        self.showAlert("Successfully!!!")
    }
    
    func showAlert(_ message: String) -> (){
        let alert = UIAlertController(title: message, message: nil , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
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
