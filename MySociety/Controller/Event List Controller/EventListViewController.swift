//
//  EventListViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var eventModelData: event?
    var eventListArry: [[String]] = [["Anmol's Birthday", "22/09/2020", "We will be having the birthday celebration for Anmol. He will be the morgan boy of the year. Lets celbrate his birthday for this year."], ["Navrathri Festival", "03/09/2020", "We will be having the birthday celebration for Anmol. Lets celbrate his birthday for this year."],["Holi 2019", "04/03/2020", "We will be having the birthday celebration for Anmol. He will be the morgan boy of the year. Lets celbrate his birthday for this year."],["Anmol's Birthday", "22/09/2020", "He will be the morgan boy of the year. Lets celbrate his birthday for this year."],]
    @IBOutlet weak var eventListTableView: UITableView!
    
    @IBAction func addEventAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "newEventAddSegue", sender: self)
    }
    @IBOutlet weak var addEventBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.eventListTableView.estimatedRowHeight = 164
        self.eventListTableView.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
        getEventData()
    }
    
    
    func getEventData(){
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
                                self.eventListTableView.reloadData()
                            }
                    case 401:
                        DispatchQueue.main.sync{
                            self.showAlert("Unauthorized User")
                        }
                    default:
                        DispatchQueue.main.sync{
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
            self.getEventData()
           }))
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
           }))
           self.present(alert, animated: true, completion: nil)
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventModelData?.eventDatas.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.eventModelData?.eventDatas.indices.contains(indexPath.row) ?? false{
            let tempEvent = self.eventModelData?.eventDatas[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventListTableViewCell") as! EventListTableViewCell
            cell.alpha = 0
            cell.eventListTitleLabel.text = tempEvent?.title ?? ""
            cell.eventListDateLabel.text = tempEvent?.date ?? ""
            cell.eventLsitDescriptionLabel.text = tempEvent?.description ?? ""
            cell.eventListBackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventListTableViewCell") as! EventListTableViewCell
            cell.alpha = 0
            
            cell.eventListBackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "EventDetailFromListOpenSegue", sender: self)
    }

}
