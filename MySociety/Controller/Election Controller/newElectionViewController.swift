//
//  newElectionViewController.swift
//  MySociety
//
//  Created by Admin on 15/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class newElectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var startTimeTitleLabel: UILabel!
    @IBOutlet weak var startTimeDatePicker: UIDatePicker!
    @IBOutlet weak var endDateTitleLabel: UILabel!
    @IBOutlet weak var endDateTimePicker: UIDatePicker!
    @IBOutlet weak var addOptionsTitleLabel: UILabel!
    
    @IBOutlet weak var addOptionTextField: UITextField!
    @IBOutlet weak var addOptionAddButton: UIButton!
    var electionOptionsArrayList: [String] = []
    @IBAction func addOptionAddBtnAction(_ sender: UIButton) {
        electionOptionsArrayList.append(self.addOptionTextField.text ?? "")
        self.optionsListTableView.reloadData()
        self.showToast(message: "Added Option", fontSize: 14.0)
        self.addOptionTextField.text = ""
    }
    
    @IBOutlet weak var optionsTitleLabel: UILabel!
    @IBOutlet weak var optionsListTableView: UITableView!
    @IBAction func postBtnAction(_ sender: UIButton) {
        if checkAndValidateFieldBfrRegister(){
            self.createElection()
        }
    }
    @IBOutlet weak var postBtn: UIButton!
    
    func checkAndValidateFieldBfrRegister() -> Bool{
        if self.subjectTextField.text == ""{
            showAlert("Please Type Subject Title")
            return false
        }else if self.startTimeDatePicker.date == self.endDateTimePicker.date  {
            showAlert("Please Select Start time and end time of election")
            return false
        }else if self.startTimeDatePicker.date > self.endDateTimePicker.date{
            showAlert("Please select proper End time!")
            return false
        }else if self.electionOptionsArrayList.count == 0 || self.electionOptionsArrayList.count == 1{
            showAlert("Please enter election Options")
            return false
        }else{
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.keyboardDismissMode = .interactive
        self.optionsListTableView.estimatedRowHeight = 83
        self.optionsListTableView.rowHeight = UITableView.automaticDimension
        self.postBtn.layer.cornerRadius = 10
        self.optionsListTableView.layer.cornerRadius = 10
//        optionsListTableView.layer.borderColor = UIColor.lightGray.cgColor
//        optionsListTableView.layer.borderWidth = 1.0
    }
    
    func createElection(){
            self.showSpinner(onView: self.view)
            let parameters = [
                "user_id": "\(loggedInUserId)",
                "subject": "\(self.subjectTextField.text ?? "")",
                "candidate_list": "\(getCandidateListOptions())",
                "start_time": "\(getDateInDateFormate(date: self.startTimeDatePicker.date))",
                "end_time": "\(getDateInDateFormate(date: self.endDateTimePicker.date))"
                ] as [String : Any]
        let headerValues = ["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"]
            let request = getRequestUrlWithHeader(url: "addelection/\(loggedInUserId)", method: "POST", header: headerValues, bodyParams: parameters)
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                DispatchQueue.main.async {
                    self.removeSpinner()
                }
                if (error != nil) {
                    print(error ?? "")
                } else {
                    let httpResponse = response as? HTTPURLResponse
//                    let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//                    print("Body: \(String(describing: strData))")
//
//                    let json: NSDictionary?
//                    do {
//                        if data != nil{
//                            json = try JSONSerialization.jsonObject(with: Data(data!), options: .allowFragments) as? NSDictionary
//                        }else{
//                            json = nil
//                        }
//                    } catch let dataError {
//                        // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
//                        print("**********")
//                        print(dataError)
//                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//                        print("Error could not parse JSON: '\(String(describing: jsonStr))'")
//                        self.showToast(message : "Some Error has occured, try after!", fontSize: CGFloat(15))
//                        // return or throw?
//                        return
//                    }
                    
                    switch(httpResponse?.statusCode ?? 201){
                    case 200, 201:
                        DispatchQueue.main.async {
                            self.showAlert("Election Created Successfully!!")
                        }
                    default:
                        DispatchQueue.main.async {
                            self.showAlert("Some Error has occured, try again!")
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
    
    @objc func removeOptionsFromList(sender:UIButton){
        if self.electionOptionsArrayList.indices.contains(sender.tag){
            self.electionOptionsArrayList.remove(at: sender.tag)
            self.optionsListTableView.reloadData()
            self.showToast(message: "Removed Option", fontSize: 14.0)
        }
    }
    
    func getCandidateListOptions() -> String{
        return electionOptionsArrayList.joined(separator: ",")
    }
    
    func getDateInDateFormate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.electionOptionsArrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newElectionTableViewCell") as! newElectionTableViewCell
        cell.alpha = 0
        cell.selectionStyle = .none
        cell.remveOptionValueBtn.tag = indexPath.row
        cell.remveOptionValueBtn.addTarget(self, action: #selector(removeOptionsFromList(sender:)), for: .touchUpInside)
        if electionOptionsArrayList.indices.contains(indexPath.row){
            cell.optionValueLabel.text = electionOptionsArrayList[indexPath.row]
            
        }
        UIView.animate(withDuration: 1) {
            cell.alpha = 1.0
        }
        return cell
    }
    

}
