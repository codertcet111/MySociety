//
//  complaintsListViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class complaintsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tempComplaintsListArray:[[String]] = [["Nahu Patil", "Subject is available", "20-12-2020", "Open"], ["Shreyansh Tipod", "Their must be a gym", "20-12-2020", "Closed"], ["Nahu Patil", "Subject is available", "20-12-2020", "Open"], ["Nahu Patil", "Subject is available", "20-12-2020", "Open"]]
    @IBOutlet weak var complaintsListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.complaintsListTableView.estimatedRowHeight = 164
        self.complaintsListTableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempComplaintsListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tempComplaintsListArray.indices.contains(indexPath.row) {
            let tempComplaint = tempComplaintsListArray[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "complaintsListTableViewCell") as! complaintsListTableViewCell
            cell.alpha = 0
            cell.complaintsCellBackgroundView.layer.cornerRadius = 10
            cell.userNameLAbel.text = tempComplaint[0]
            cell.subjectLbel.text = tempComplaint[1]
            cell.dateAndTimeLabel.text = tempComplaint[2]
            cell.statusLabel.text = tempComplaint[3]
            cell.selectionStyle = .none
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
        self.performSegue(withIdentifier: "complaintDetailFromListSegue", sender: self)
    }

}
