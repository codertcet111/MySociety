//
//  complaintsListViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class complaintsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var complaintsListModel: complaints?
    var tempComplaintsListArray:[[String]] = [["Nahu Patil", "Subject is available", "20-12-2020", "Open"], ["Shreyansh Tipod", "Their must be a gym", "20-12-2020", "Closed"], ["Nahu Patil", "Subject is available", "20-12-2020", "Open"], ["Nahu Patil", "Subject is available", "20-12-2020", "Open"]]
    var selectedComplainRowIndex = 0
    @IBOutlet weak var complaintsListTableView: UITableView!
    @IBOutlet weak var complaintListNewComplaintBtn: UIButton!
    
    @IBAction func complaintListNewComplaintAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "newComplaintSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.complaintsListTableView.estimatedRowHeight = 164
        self.complaintsListTableView.rowHeight = UITableView.automaticDimension
        getComplaintsData()
//        if isAdminLoggedIn{
//            self.complaintListNewComplaintBtn.isHidden = true
//        }
    }
    
    func getComplaintsData(){
        showSpinner(onView: self.view)
            let headerValues = globalHeaderValue
        let request = getRequestUrlWithHeader(url: "complaints/\(loggedInUserId)/\(isAdminLoggedIn ? 1 : 0)", method: "GET", header: headerValues , bodyParams: nil)
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
                            self.complaintsListModel = try? JSONDecoder().decode(complaints.self,from: data!)
                                DispatchQueue.main.sync {
                                    if self.complaintsListModel?.complaintsData.count == 0{
                                        self.complaintsListTableView.isHidden = true
                                        self.showToast(message: "NO Data!", fontSize: 11.0)
                                    }else{
                                        self.complaintsListTableView.reloadData()
                                    }
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
            self.getComplaintsData()
           }))
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
           }))
           self.present(alert, animated: true, completion: nil)
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "complaintDetailFromListSegue") {
            let vc = segue.destination as! ComplaintDetailViewController
            vc.complaintId = self.complaintsListModel?.complaintsData[self.selectedComplainRowIndex].complainId ?? 0
            vc.username = self.complaintsListModel?.complaintsData[self.selectedComplainRowIndex].userName ?? ""
            vc.commentText = self.complaintsListModel?.complaintsData[self.selectedComplainRowIndex].subject ?? ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.complaintsListModel?.complaintsData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.complaintsListModel?.complaintsData.indices.contains(indexPath.row) ?? false{
            let tempchat = self.complaintsListModel?.complaintsData[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "complaintsListTableViewCell") as! complaintsListTableViewCell
            cell.alpha = 0
            cell.complaintsCellBackgroundView.layer.cornerRadius = 10
            cell.userNameLAbel.text = tempchat?.userName ?? ""
            cell.subjectLbel.text = tempchat?.subject ?? ""
            cell.dateAndTimeLabel.text = tempchat?.date ?? ""
            cell.statusLabel.text = tempchat?.status ?? 0 == 0 ? "Open" : "Closed"
            cell.selectionStyle = .none
            cell.complaintsCellBackgroundView.giveBorder()
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "complaintsListTableViewCell") as! complaintsListTableViewCell
            cell.alpha = 0
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedComplainRowIndex = indexPath.row
        self.performSegue(withIdentifier: "complaintDetailFromListSegue", sender: self)
    }

}
