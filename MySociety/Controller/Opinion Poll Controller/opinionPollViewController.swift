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
    var opinionPollModelObject: OpenionPollList?
    @IBOutlet weak var createOpinionollBtn: UIButton!
    @IBAction func createOpinionPollAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "createOpinionPollFromListSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getPollListData()
    }
    
    func getPollListData(){
        showSpinner(onView: self.view)
        let headerValues = globalHeaderValue
        let request = getRequestUrlWithHeader(url: "openionpoll/\(loggedInUserId)", method: "GET", header: headerValues , bodyParams: nil)
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
                        self.opinionPollModelObject = try? JSONDecoder().decode(OpenionPollList.self,from: data!)
                            DispatchQueue.main.sync {
                                self.opinionPollTableView.reloadData()
                                self.removeSpinner()
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
            self.getPollListData()
           }))
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
           }))
           self.present(alert, animated: true, completion: nil)
       }
    
    @objc func AvoteButtonAction(sender:UIButton)
    {
        //Send Post request for voted Id
        //Then Rehit the Get Api for opinion Poll
        //Refresh the Table view
        print("A \(sender.tag)")
        self.opinionPollTableView.reloadData()
    }
    @objc func BvoteButtonAction(sender:UIButton)
    {
        //Send Post request for voted Id
        //Then Rehit the Get Api for opinion Poll
        //Refresh the Table view
        print("B \(sender.tag)")
        self.opinionPollTableView.reloadData()
    }
    @objc func CvoteButtonAction(sender:UIButton)
    {
        //Send Post request for voted Id
        //Then Rehit the Get Api for opinion Poll
        //Refresh the Table view
        print("C \(sender.tag)")
        self.opinionPollTableView.reloadData()
    }
    @objc func DvoteButtonAction(sender:UIButton)
    {
        //Send Post request for voted Id
        //Then Rehit the Get Api for opinion Poll
        //Refresh the Table view
        print("D \(sender.tag)")
        self.opinionPollTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.opinionPollModelObject?.opinionPoll.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tempOpenionData = self.opinionPollModelObject?.opinionPoll[indexPath.row]{
            let votedUsersID = tempOpenionData.votedUserIds.components(separatedBy: ",")
            var switchCaseId = 0
            if tempOpenionData.cellType == "0"{
                switchCaseId = votedUsersID.contains("\(loggedInUserId)") ? 1 : 0
            }else{
                switchCaseId = 2
            }
            switch(switchCaseId){
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "opinionPollLiveVoteItTableViewCell") as! opinionPollLiveVoteItTableViewCell
                cell.alpha = 0
                cell.liveVoteBackgroundView.layer.cornerRadius = 10.0
                cell.subjectLabel.text = tempOpenionData.subject
                let getAnswersArray = (tempOpenionData.options).components(separatedBy: ",")
                cell.answerALabel.text = getAnswersArray.indices.contains(0) ? getAnswersArray[0] : ""
                cell.answerBLabel.text = getAnswersArray.indices.contains(1) ? getAnswersArray[1] : ""
                cell.answerCLAbel.text = getAnswersArray.indices.contains(2) ? getAnswersArray[2] : ""
                cell.answerDLabel.text = getAnswersArray.indices.contains(3) ? getAnswersArray[3] : ""
                cell.answerAVoteBtn.addTarget(self, action: #selector(AvoteButtonAction(sender:)), for: .touchUpInside)
                cell.answerBVoteBtn.addTarget(self, action: #selector(BvoteButtonAction(sender:)), for: .touchUpInside)
                cell.answerCVoteBtn.addTarget(self, action: #selector(CvoteButtonAction(sender:)), for: .touchUpInside)
                cell.answerDVoteBtn.addTarget(self, action: #selector(DvoteButtonAction(sender:)), for: .touchUpInside)
                cell.answerAVoteBtn.tag = indexPath.row
                cell.answerBVoteBtn.tag = indexPath.row
                cell.answerCVoteBtn.tag = indexPath.row
                cell.answerDVoteBtn.tag = indexPath.row
                //Give the tags
                cell.answerAVoteBtn.tag = indexPath.row
                
                cell.endDateLabel.text = "End Time: \(tempOpenionData.endDateTime)"
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
                cell.subjectLabel.text = tempOpenionData.subject
                let getAnswersArray = (tempOpenionData.options).components(separatedBy: ",")
                cell.answerALabel.text = getAnswersArray.indices.contains(0) ? getAnswersArray[0] : ""
                cell.answerBLabel.text = getAnswersArray.indices.contains(1) ? getAnswersArray[1] : ""
                cell.answerCLabel.text = getAnswersArray.indices.contains(2) ? getAnswersArray[2] : ""
                cell.answerDLabel.text = getAnswersArray.indices.contains(3) ? getAnswersArray[3] : ""
                
                let votedCountForOption = (tempOpenionData.voteCountList).components(separatedBy: ",")
                cell.answerAProgressBar.progress = 0
                cell.answerAProgressBar.progress = Float(votedCountForOption.indices.contains(0) ? votedCountForOption[0] : "") ?? 0
                cell.answerAVotePercenatge.text = "\(Float(votedCountForOption.indices.contains(0) ? votedCountForOption[0] : "") ?? 0)"
                cell.answerBProgressBar.progress = 0
                cell.answerBProgressBar.progress = Float(votedCountForOption.indices.contains(1) ? votedCountForOption[1] : "") ?? 0
                cell.answerBVotePercentage.text = "\(Float(votedCountForOption.indices.contains(1) ? votedCountForOption[1] : "") ?? 0)"
                
                cell.answerCProgressBar.progress = 0
                cell.answerCProgressBar.progress = Float(votedCountForOption.indices.contains(2) ? votedCountForOption[2] : "") ?? 0
                cell.answerCVotePercentage.text = "\(Float(votedCountForOption.indices.contains(2) ? votedCountForOption[2] : "") ?? 0)"
                
                cell.answerDProgressBar.progress = 0
                cell.answerDProgressBar.progress = Float(votedCountForOption.indices.contains(3) ? votedCountForOption[3] : "") ?? 0
                cell.answerDVotePercetage.text = "\(Float(votedCountForOption.indices.contains(3) ? votedCountForOption[3] : "") ?? 0)"
                cell.endDateTimeLabel.text = tempOpenionData.endDateTime
                UIView.animate(withDuration: 1) {
                    cell.alpha = 1.0
                }
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "opinionPollResultTableViewCell") as! opinionPollResultTableViewCell
                cell.alpha = 0
                cell.resultBackgoundView.layer.cornerRadius = 10.0
                cell.selectionStyle = .none
                cell.resultLabel.text = tempOpenionData.result ?? ""
                cell.subjectLabel.text = tempOpenionData.subject
                let getAnswersArray = (tempOpenionData.options).components(separatedBy: ",")
                cell.answerALAbel.text = getAnswersArray.indices.contains(0) ? getAnswersArray[0] : ""
                cell.answerBLabel.text = getAnswersArray.indices.contains(1) ? getAnswersArray[1] : ""
                cell.answerCLabel.text = getAnswersArray.indices.contains(2) ? getAnswersArray[2] : ""
                cell.answreDLabel.text = getAnswersArray.indices.contains(3) ? getAnswersArray[3] : ""
                
                let votedCountForOption = (tempOpenionData.voteCountList).components(separatedBy: ",")
                
                cell.answerATotalVoteCount.text = "\(Float(votedCountForOption.indices.contains(0) ? votedCountForOption[0] : "") ?? 0)"
                cell.answerBTotalVoteCOunt.text = "\(Float(votedCountForOption.indices.contains(1) ? votedCountForOption[1] : "") ?? 0)"
                cell.answerCTotalVoteCount.text = "\(Float(votedCountForOption.indices.contains(2) ? votedCountForOption[2] : "") ?? 0)"
                cell.answerDTotalVoteCount.text = "\(Float(votedCountForOption.indices.contains(3) ? votedCountForOption[3] : "") ?? 0)"
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
        else{
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
