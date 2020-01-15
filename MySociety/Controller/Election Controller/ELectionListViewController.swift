//
//  ELectionListViewController.swift
//  MySociety
//
//  Created by Admin on 15/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ELectionListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var electionListTableView: UITableView!
    var insideTableViewTagCount = 0
    
    @IBOutlet weak var addElectionBtn: UIButton!
    
    @IBAction func addElectionBtnAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "newElectionFromListSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.electionListTableView.estimatedRowHeight = 325
        self.electionListTableView.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 999{
            return 6
        }else{
            //THis will be the inside table's cells items, so u can use the tableview.tag for getting correct data, index position
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 999{
            switch(indexPath.row){
            case 0, 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "liveElectionListTableViewCell") as! liveElectionListTableViewCell
                cell.alpha = 0
                cell.liveElectionListBackgroundView.layer.cornerRadius = 10
                cell.electionInsideTableView.tag = insideTableViewTagCount
//                cell.electionInsideTableViewHeight.constant = 60 * (numberOfOptionsInsideElection)
                cell.electionInsideTableViewHeight.constant = 60 * 4.0
                insideTableViewTagCount += 1
//                cell.electionInsideTableView.reloadData()
                cell.selectionStyle = .none
                UIView.animate(withDuration: 1) {
                    cell.alpha = 1.0
                }
                return cell
            case 2, 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingElectionTableViewCell") as! UpcomingElectionTableViewCell
                cell.alpha = 0
                cell.upcomingElectionBackgroundView.layer.cornerRadius = 10
                cell.selectionStyle = .none
                UIView.animate(withDuration: 1) {
                    cell.alpha = 1.0
                }
                return cell
            case 4, 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ResultElectionListTableViewCell") as! ResultElectionListTableViewCell
                cell.alpha = 0
                cell.resultElectionBackgroundView.layer.cornerRadius = 10
                cell.selectionStyle = .none
                UIView.animate(withDuration: 1) {
                    cell.alpha = 1.0
                }
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ResultElectionListTableViewCell") as! ResultElectionListTableViewCell
                cell.alpha = 0
                cell.selectionStyle = .none
                UIView.animate(withDuration: 1) {
                    cell.alpha = 1.0
                }
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ElectionLiveInsideTableViewCell") as! ElectionLiveInsideTableViewCell
            cell.alpha = 0
            cell.selectionStyle = .none
            print(tableView.tag)
            print(cell.electionOptionsLabel.text)
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }
    }
}
