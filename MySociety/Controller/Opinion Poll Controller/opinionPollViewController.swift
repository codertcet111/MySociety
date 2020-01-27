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
    var firstopinionPollFirstCellData = ["Vote for new Gym","We do need the gym","We don't need the gym","May be needed", "No idea"]
    var SecondopinionPollFirstCellData = ["Vote for garbage collector","We do need this now","We don't need this now","May be needed", "No idea"]
    var isVoted = false
    var secondCellVotedCellData = [50, 34, 24, 56]
    var endDateTime: String = "23/03/2020 08:30PM"
    var lastopinionPollFirstCellData = ["Vote for Event plan","Party all night","Meditation camp for one day","Helping NGO's on holidays", "No idea"]
    var result = "The People opted for Party"
    
    @IBOutlet weak var createOpinionollBtn: UIButton!
    @IBAction func createOpinionPollAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "createOpinionPollFromListSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonAction(sender:UIButton)
    {
        self.isVoted = true
        self.opinionPollTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var switchItem = indexPath.row
        if indexPath.row == 0 && isVoted{
            switchItem = 1
        }
        switch(switchItem){
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "opinionPollLiveVoteItTableViewCell") as! opinionPollLiveVoteItTableViewCell
            cell.alpha = 0
            cell.liveVoteBackgroundView.layer.cornerRadius = 10.0
            cell.subjectLabel.text = firstopinionPollFirstCellData[0]
            cell.answerALabel.text = firstopinionPollFirstCellData[1]
            cell.answerBLabel.text = firstopinionPollFirstCellData[2]
            cell.answerCLAbel.text = firstopinionPollFirstCellData[3]
            cell.answerDLabel.text = firstopinionPollFirstCellData[4]
            cell.answerAVoteBtn.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            cell.answerBVoteBtn.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            cell.answerCVoteBtn.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            cell.answerDVoteBtn.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            cell.endDateLabel.text = self.endDateTime
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
            cell.subjectLabel.text = SecondopinionPollFirstCellData[0]
            cell.answerALabel.text = SecondopinionPollFirstCellData[1]
            cell.answerBLabel.text = SecondopinionPollFirstCellData[2]
            cell.answerCLabel.text = SecondopinionPollFirstCellData[3]
            cell.answerDLabel.text = SecondopinionPollFirstCellData[4]
            cell.answerAProgressBar.progress = 0
            cell.answerAProgressBar.progress = Float(secondCellVotedCellData[0])
            cell.answerAVotePercenatge.text = "\(secondCellVotedCellData[0])"
            cell.answerBProgressBar.progress = 0
            cell.answerBProgressBar.progress = Float(secondCellVotedCellData[1])
            cell.answerBVotePercentage.text = "\(secondCellVotedCellData[1])"
            
            cell.answerCProgressBar.progress = 0
            cell.answerCProgressBar.progress = Float(secondCellVotedCellData[2])
            cell.answerCVotePercentage.text = "\(secondCellVotedCellData[2])"
            
            cell.answerDProgressBar.progress = 0
            cell.answerDProgressBar.progress = Float(secondCellVotedCellData[3])
            cell.answerDVotePercetage.text = "\(secondCellVotedCellData[3])"
            cell.endDateTimeLabel.text = self.endDateTime
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "opinionPollResultTableViewCell") as! opinionPollResultTableViewCell
            cell.alpha = 0
            cell.resultBackgoundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            cell.resultLabel.text = result
            cell.subjectLabel.text = lastopinionPollFirstCellData[0]
            cell.answerALAbel.text = lastopinionPollFirstCellData[1]
            cell.answerBLabel.text = lastopinionPollFirstCellData[2]
            cell.answerCLabel.text = lastopinionPollFirstCellData[3]
            cell.answreDLabel.text = lastopinionPollFirstCellData[4]
            cell.answerATotalVoteCount.text = "\(secondCellVotedCellData[0])"
            cell.answerBTotalVoteCOunt.text = "\(secondCellVotedCellData[1])"
            cell.answerCTotalVoteCount.text = "\(secondCellVotedCellData[2])"
            cell.answerDTotalVoteCount.text = "\(secondCellVotedCellData[3])"
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
