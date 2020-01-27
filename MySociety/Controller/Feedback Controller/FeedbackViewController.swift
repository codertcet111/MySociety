//
//  FeedbackViewController.swift
//  MySociety
//
//  Created by Admin on 15/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var feedbackTableView: UITableView!
    @IBOutlet weak var typeFeedbackView: UIView!
    @IBOutlet weak var selectEventButton: UIButton!
    var feedbackModelData: FeedbackList?
    @IBAction func selectEventBtnAction(_ sender: UIButton) {
        //Fetch and show all events Availabel
        let alert = UIAlertController(title: "Select Event", message: nil, preferredStyle: .alert)
        
        let closure = { (action: UIAlertAction!) -> Void in
            self.selectEventButton.setTitle(action.title, for: .normal)
            let indexForEventSelected = self.eventModelData?.eventDatas.firstIndex(where: {($0.title ) == "\(action.title ?? "")"})
            self.selectedEventName = action.title ?? ""
            self.slectedEventId = self.eventModelData?.eventDatas[indexForEventSelected ?? 0].eventId
        }
        for eventData in self.eventModelData?.eventDatas ?? [] {
            alert.addAction(UIAlertAction(title: eventData.title, style: .default, handler: closure))
        }
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: {(_) in }))
        self.present(alert, animated: false, completion: nil)
    }
    
    @IBOutlet weak var commentTypeTextField: UITextField!
    
    @IBAction func textField(_ sender: AnyObject) {
        self.view.endEditing(true);
    }
    
    @IBOutlet weak var postBtn: UIButton!
    @IBAction func postBtnAction(_ sender: UIButton) {
        postFeedback()
        self.commentTypeTextField.text = ""
    }
    
    var eventModelData: event?
    var selectedEventName: String?
    var slectedEventId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedbackTableView.estimatedRowHeight = 150
        self.feedbackTableView.rowHeight = UITableView.automaticDimension
        postBtn.layer.cornerRadius = 10
        selectEventButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        getSetEventData()
    }
    
    func getSetEventData(){
        showSpinner(onView: self.view)
            let headerValues = globalHeaderValue
            let request = getRequestUrlWithHeader(url: "event/\(loggedInUserId)", method: "GET", header: headerValues , bodyParams: nil)
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                self.removeSpinner()
                if (error != nil) {
                    print(error ?? "")
                } else {
                    let httpResponse = response as? HTTPURLResponse
                    let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Body: \(String(describing: strData))")
                    
                    if(response != nil && data != nil){
                        switch  httpResponse?.statusCode {
                        case 200:
                            self.eventModelData = try? JSONDecoder().decode(event.self,from: data!)
                                DispatchQueue.main.sync {
                                    //Got the event data
                                    self.showToast(message: "Select the Event and give feedback ", fontSize: 11.0)
                                    self.getFeedbackData(false)
                                    
                                }
                        case 401:
                            DispatchQueue.main.sync {
                                self.showAlert("Unauthorized User", 0)
                            }
                        default:
                            DispatchQueue.main.sync {
                                self.showAlert("something Went Wrong Message", 0)
                            }
                        }
                    }else{
                        self.showAlert("No data!", 0)
                    }
                }
            })
            dataTask.resume()
        }
    
    func postFeedback(){
        self.showSpinner(onView: self.view)
        let parameters = [
            "description": "\(self.commentTypeTextField.text ?? "")",
            "event_id": "\(self.slectedEventId ?? 0)",
            "user_id": "\(loggedInUserId)"
            ] as [String : Any]
        let headerValues = ["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"]
        let request = getRequestUrlWithHeader(url: "addfeedback/\(loggedInUserId)", method: "POST", header: headerValues, bodyParams: parameters)
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
                        self.showAlertForError("Feedback Posted Successfully!!")
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
    
        
    func showAlert(_ message: String,_ eventOrFeedback: Int) -> (){
       let alert = UIAlertController(title: message, message: nil , preferredStyle: UIAlertController.Style.alert)
       alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: { _ in
        if eventOrFeedback == 0{
            self.getSetEventData()
        }else{
            self.getFeedbackData(false)
        }
       }))
       alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
       }))
       self.present(alert, animated: true, completion: nil)
   }
    
    
    func getFeedbackData(_ showSpinnerView: Bool){
        if showSpinnerView{
            showSpinner(onView: self.view)
        }
        let headerValues = globalHeaderValue
        let request = getRequestUrlWithHeader(url: "feedback/\(loggedInUserId)", method: "GET", header: headerValues , bodyParams: nil)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            self.removeSpinner()
            if (error != nil) {
                print(error ?? "")
            } else {
                let httpResponse = response as? HTTPURLResponse
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Body: \(String(describing: strData))")
                
                if(response != nil && data != nil){
                    switch  httpResponse?.statusCode {
                    case 200:
                        self.feedbackModelData = try? JSONDecoder().decode(FeedbackList.self,from: data!)
                            DispatchQueue.main.sync {
                                self.feedbackTableView.reloadData()
                                self.removeSpinner()
                            }
                    case 401:
                        DispatchQueue.main.sync{
                            self.showAlert("Unauthorized User", 1)
                        }
                    default:
                        DispatchQueue.main.sync{
                            self.showAlert("something Went Wrong Message", 1)
                        }
                    }
                }else{
                    self.showAlert("No data!", 1)
                }
            }
        })
        dataTask.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedbackModelData?.feedbackData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedbackTableViewCell") as! feedbackTableViewCell
       cell.alpha = 0
       cell.feedbackCellBackgroundView.layer.cornerRadius = 10
       
        if self.feedbackModelData?.feedbackData.indices.contains(indexPath.row) ?? false{
            cell.eventNameLabel.text = self.feedbackModelData?.feedbackData[indexPath.row].eventName ?? ""
            cell.userDescriptionTextLabel.text = self.feedbackModelData?.feedbackData[indexPath.row].description ?? ""
            cell.userName.text = self.feedbackModelData?.feedbackData[indexPath.row].fullName ?? ""
        }
        
       cell.selectionStyle = .none
       UIView.animate(withDuration: 1) {
           cell.alpha = 1.0
       }
       return cell
    }

}
