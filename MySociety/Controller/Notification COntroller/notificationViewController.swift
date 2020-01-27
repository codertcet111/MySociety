//
//  notificationViewController.swift
//  MySociety
//
//  Created by Admin on 17/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class notificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var notificationTableView: UITableView!
    var notificationTempData: [String] = ["A new video uploaded for navaratri event by Shubham", "New Event notice has uploaded", "New gymnasuium will be install", "New Election will be coming in the next month", "A new video for the recent meeting uploaded", "New Event notice has uploaded"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notificationTableView.estimatedRowHeight = 71
        self.notificationTableView.rowHeight = UITableView.automaticDimension
//        notificationTableView.layer.cornerRadius = 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationTableViewCell") as! notificationTableViewCell
        cell.alpha = 0
        cell.CellbackgroundView.layer.cornerRadius = 10
//        cell.textLabel?.text = notificationTempData[indexPath.row]
        cell.selectionStyle = .none
        UIView.animate(withDuration: 1) {
            cell.alpha = 1.0
        }
        return cell
    }

}
