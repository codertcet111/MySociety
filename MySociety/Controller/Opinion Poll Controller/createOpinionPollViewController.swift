//
//  createOpinionPollViewController.swift
//  MySociety
//
//  Created by Admin on 14/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class createOpinionPollViewController: UIViewController {

    @IBOutlet weak var subjectTitleLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainViewHeightConstraint: NSLayoutConstraint!
    //Default 900
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
        self.mainViewHeightConstraint.constant = 1000
        self.view.layoutIfNeeded()
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        // Do something here.
        self.mainViewHeightConstraint.constant = 900
        self.view.layoutIfNeeded()
    }
    
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var ATitleLabel: UILabel!
    @IBOutlet weak var ATextField: UITextField!
    @IBOutlet weak var BTitleLabel: UILabel!
    @IBOutlet weak var BTextField: UITextField!
    @IBOutlet weak var CTitleLabel: UILabel!
    @IBOutlet weak var CTextField: UITextField!
    @IBOutlet weak var DTitleLabel: UILabel!
    @IBOutlet weak var DTextField: UITextField!
    @IBOutlet weak var ExpDateAndTimeTitleLabel: UILabel!
    @IBOutlet weak var expDateAndTimePicker: UIDatePicker!
    @IBOutlet weak var CreatePollCreateBtn: UIButton!
    
    @objc func CreateOpinionPollAction(sender:UIButton)
    {
        if subjectTextField.text ?? "" == ""{
            showToast(message: "Type Subject for Poll", fontSize: 11.0)
        }else if ATextField.text ?? "" == ""{
            showToast(message: "Type Option A", fontSize: 11.0)
        }else if BTextField.text ?? "" == ""{
            showToast(message: "Type Option B", fontSize: 11.0)
        }else if CTextField.text ?? "" == ""{
            showToast(message: "Type Option C", fontSize: 11.0)
        }else if DTextField.text ?? "" == ""{
            showToast(message: "Type Option D", fontSize: 11.0)
        }else{
            self.postOpinionPoll()
        }
    }
    
    func postOpinionPoll(){
        self.showSpinner(onView: self.view)
        let parameters = [
            "subject": "\(self.subjectTextField.text ?? "")",
            "option_list": "\(ATextField.text ?? ""),\(BTextField.text ?? ""),\(CTextField.text ?? ""),\(DTextField.text ?? "")",
            "user_id": "\(loggedInUserId)",
            "end_time": "\(self.getDateInDateFormate(date: self.expDateAndTimePicker.date))"
            ] as [String : Any]
        let headerValues = ["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"]
        let request = getRequestUrlWithHeader(url: "addopenionpoll/\(loggedInUserId)", method: "POST", header: headerValues, bodyParams: parameters)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.removeSpinner()
            }
            if (error != nil) {
                print(error ?? "")
            } else {
                let httpResponse = response as? HTTPURLResponse
                
                switch(httpResponse?.statusCode ?? 201){
                case 200, 201:
                    DispatchQueue.main.async {
                        self.showToast(message: "Opinion Poll created Successfully!!", fontSize: 11.0)
                        self.navigationController?.popViewController(animated: true)
                    }
                default:
                    DispatchQueue.main.async {
                        self.showAlertForError("Some Error has occured, try again!")
                    }
                }
            }
        })
        
        dataTask.resume()
    }
        
    func getDateInDateFormate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
    
    func showAlertForError(_ message: String) -> (){
        let alert = UIAlertController(title: message, message: nil , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CreatePollCreateBtn.addTarget(self, action: #selector(CreateOpinionPollAction(sender:)), for: .touchUpInside)
        self.scrollView.keyboardDismissMode = .interactive
        // Do any additional setup after loading the view.
    }
    

}
