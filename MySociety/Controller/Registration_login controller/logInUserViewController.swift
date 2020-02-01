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
        self.showSpinner(onView: self.view)
        let parameters = [
            "userName": "\(self.userNameTextField.text ?? "")",
            "password": "\(self.passwordTextField.text ?? "")"
            ] as [String : Any]
        let headerValues = ["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"]
        let request = getRequestUrlWithHeader(url: "login", method: "POST", header: headerValues, bodyParams: parameters)
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
                            if json?.value(forKey: "Error") != nil{
                                self.showAlert("\(json?.value(forKey: "Error") as? String ?? "Unauthorised")")
                            }else{
                                let userId = (json?.value(forKey: "id") as? Int ?? 0)
                                let isAdmin = (json?.value(forKey: "roleId") as? Int ?? 0) == 0 ? false : true
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
                        }
                    default:
                        DispatchQueue.main.sync {
                            self.showToast(message: "\(json?.value(forKey: "Error") as? String ?? "Unauthorised")", fontSize: 14.0)
                        }
                    }
                }
            }
        })
        
        dataTask.resume()
    }
        
    func showAlertForError(_ message: String) -> (){
        let alert = UIAlertController(title: message, message: nil , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
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
