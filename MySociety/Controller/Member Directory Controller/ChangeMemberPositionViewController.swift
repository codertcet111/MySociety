//
//  ChangeMemberPositionViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ChangeMemberPositionViewController: UIViewController {

    let nc = NotificationCenter.default
    var selectedMemberId: Int = 0
    var selectedMemberName: String = ""
    var rolesArray = ["Secretary", "Chairman", "Treasurer"]
    var selectedRole: Int = 0
    @IBOutlet weak var selectMemberTitleLabel: UILabel!
    @IBOutlet weak var selectMemberButton: UIButton!
    
    @IBAction func selectMemberAction(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var selectPositionTitleLabel: UILabel!
    
    @IBOutlet weak var selectPositionBtn: UIButton!
    
    @IBAction func selectPositionAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Select Role", message: nil, preferredStyle: .alert)
        
        let closure = { (action: UIAlertAction!) -> Void in
            self.selectPositionBtn.setTitle(action.title, for: .normal)
            self.selectedRole = self.rolesArray.firstIndex(where: {$0 == action.title}) ?? 0
        }
        for tempRole in rolesArray {
            alert.addAction(UIAlertAction(title: tempRole, style: .default, handler: closure))
        }
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: {(_) in }))
        self.present(alert, animated: false, completion: nil)
    }
    
    @IBOutlet weak var updateButton: UIButton!
    
    @IBAction func updateAction(_ sender: UIButton) {
        self.changeMmeberPositionRequest()
    }
    
    func changeMmeberPositionRequest(){
        self.showSpinner(onView: self.view)
        let parameters = [
            "selected_user_id": self.selectedMemberId,
            "selected_position": self.selectedRole
            ] as [String : Any]
        let headerValues = ["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"]
        let request = getRequestUrlWithHeader(url: "make-position-change", method: "POST", header: headerValues, bodyParams: parameters)
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
                        self.showAlertForError("Position changed Successfully!!")
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
        
    func showAlertForError(_ message: String) -> (){
        let alert = UIAlertController(title: message, message: nil , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectPositionBtn.layer.cornerRadius = 10
        self.updateButton.layer.cornerRadius = 10
        self.selectMemberButton.layer.cornerRadius  = 10
        // Do any additional setup after loading the view.
        nc.addObserver(self, selector: #selector(updateSelectedMemberLabels), name: Notification.Name.selectUserMemberPopOverDismissNC, object: nil)
    }
    
    @objc func updateSelectedMemberLabels(){
        self.selectMemberButton.setTitle("\(selectMemberSharedFile.shared.memberSelectedName)", for: .normal)
        self.selectedMemberId = selectMemberSharedFile.shared.memberSelectedId
    }

}
