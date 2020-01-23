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
    
    @IBOutlet weak var postBtn: UIButton!
    @IBAction func postBtnAction(_ sender: UIButton) {
        
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
                                    self.showAlert("Select the Event and give feedback 😁")
                                }
                        case 401:
                            DispatchQueue.main.sync {
                                self.showAlert("Unauthorized User")
                            }
                        default:
                            DispatchQueue.main.sync {
                                self.showAlert("something Went Wrong Message")
                            }
                        }
                    }else{
                        self.showAlert("No data!")
                    }
                }
            })
            dataTask.resume()
        }
        
        func showAlert(_ message: String) -> (){
               let alert = UIAlertController(title: message, message: nil , preferredStyle: UIAlertController.Style.alert)
               alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: { _ in
                self.getSetEventData()
               }))
               alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
               }))
               self.present(alert, animated: true, completion: nil)
           }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedbackTableViewCell") as! feedbackTableViewCell
       cell.alpha = 0
       cell.feedbackCellBackgroundView.layer.cornerRadius = 10
       
       cell.selectionStyle = .none
       UIView.animate(withDuration: 1) {
           cell.alpha = 1.0
       }
       return cell
    }

}
