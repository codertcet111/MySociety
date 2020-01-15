//
//  maintenanceListViewController.swift
//  MySociety
//
//  Created by Admin on 15/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class maintenanceListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var maintenanceTableView: UITableView!
    
    @IBOutlet weak var payMaintenanceBtn: UIButton!
    
    @IBAction func payMaintenanceBtnAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "payMaintenanceSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.maintenanceTableView.estimatedRowHeight = 164
        self.maintenanceTableView.rowHeight = UITableView.automaticDimension
        payMaintenanceBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "maintenanceTableViewCell") as! maintenanceTableViewCell
        cell.alpha = 0
        cell.maintenanceBackgroundView.layer.cornerRadius = 10
        cell.statusBtn.layer.cornerRadius = 10
        cell.selectionStyle = .none
        UIView.animate(withDuration: 1) {
            cell.alpha = 1.0
        }
        return cell
    }

}
