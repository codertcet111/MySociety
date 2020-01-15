//
//  opinionPollViewController.swift
//  MySociety
//
//  Created by Admin on 14/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class opinionPollViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

//    var opinionPollTempData: [[String]] = [["0","Should we install the Gym?", "Yes, Must COmpulsory", "No way, not needed", "May be harmful for the society", "Yup we should"]]
    @IBOutlet weak var opinionPollTableView: UITableView!
    @IBOutlet weak var createOpinionollBtn: UIButton!
    @IBAction func createOpinionPollAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "createOpinionPollFromListSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.row){
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "opinionPollLiveVoteItTableViewCell") as! opinionPollLiveVoteItTableViewCell
            cell.alpha = 0
            cell.liveVoteBackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "opinionPollLiveVotedTableViewCell") as! opinionPollLiveVotedTableViewCell
            cell.alpha = 0
            cell.votedBackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "opinionPollResultTableViewCell") as! opinionPollResultTableViewCell
            cell.alpha = 0
            cell.resultBackgoundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "opinionPollLiveVoteItTableViewCell") as! opinionPollLiveVoteItTableViewCell
            cell.alpha = 0
            cell.liveVoteBackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }
    }
    

}
