//
//  EventListViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventListArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventListTableViewCell") as! EventListTableViewCell
        cell.alpha = 0
        let tempNotice = self.eventListArry[indexPath.row]
        cell.eventListTitleLabel.text = tempNotice[0]
        cell.eventListDateLabel.text = tempNotice[1]
        cell.eventLsitDescriptionLabel.text = tempNotice[2]
        cell.eventListBackgroundView.layer.cornerRadius = 10.0
        cell.selectionStyle = .none
        UIView.animate(withDuration: 1) {
            cell.alpha = 1.0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "EventDetailFromListOpenSegue", sender: self)
    }

}
