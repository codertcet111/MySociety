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
        if !isAdminLoggedIn{
            self.createOpinionollBtn.isHidden = true
            
        }
    }
    
    var isFirstLoad: Bool = true
    override func viewWillAppear(_ animated: Bool) {
        self.getPollListData(self.isFirstLoad)
        self.isFirstLoad = false
    }
    
    func getPollListData(_ showSpinnerAnimation: Bool){
        if showSpinnerAnimation{
            showSpinner(onView: self.view)
        }
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
            self.getPollListData(true)
           }))
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
           }))
           self.present(alert, animated: true, completion: nil)
       }
    
    @objc func AvoteButtonAction(sender:UIButton)
    {
        //Send Post request for voted Id
        voteForPoll(self.opinionPollModelObject?.opinionPoll[sender.tag].openionpollId ?? 0,0)
        //Then Rehit the Get Api for opinion Poll
        //Refresh the Table view
        print("A \(sender.tag)")
//        self.opinionPollTableView.reloadData()
    }
    @objc func BvoteButtonAction(sender:UIButton)
    {
        //Send Post request for voted Id
        voteForPoll(self.opinionPollModelObject?.opinionPoll[sender.tag].openionpollId ?? 0,1)
        //Then Rehit the Get Api for opinion Poll
        //Refresh the Table view
        print("B \(sender.tag)")
//        self.opinionPollTableView.reloadData()
    }
    @objc func CvoteButtonAction(sender:UIButton)
    {
        //Send Post request for voted Id
        voteForPoll(self.opinionPollModelObject?.opinionPoll[sender.tag].openionpollId ?? 0,2)
        //Then Rehit the Get Api for opinion Poll
        //Refresh the Table view
        print("C \(sender.tag)")
//        self.opinionPollTableView.reloadData()
    }
    @objc func DvoteButtonAction(sender:UIButton)
    {
        //Send Post request for voted Id
        voteForPoll(self.opinionPollModelObject?.opinionPoll[sender.tag].openionpollId ?? 0,3)
        //Then Rehit the Get Api for opinion Poll
        //Refresh the Table view
        print("D \(sender.tag)")
//        self.opinionPollTableView.reloadData()
    }
    
    func voteForPoll(_ pollId: Int,_ optionIndex: Int){
        self.showSpinner(onView: self.view)
        let parameters = [
            "poll_id": pollId,
            "option": optionIndex,
            "user_id": "\(loggedInUserId)"
            ] as [String : Any]
        let headerValues = ["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"]
        let request = getRequestUrlWithHeader(url: "openionpollvote", method: "POST", header: headerValues, bodyParams: parameters)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.removeSpinner()
            }
            if (error != nil) {
                print(error ?? "")
            } else {
                let httpResponse = response as? HTTPURLResponse
                
                switch(httpResponse?.statusCode ?? 201){
                case 200, 201:
                    DispatchQueue.main.async {
                        self.showAlertForError("Voted Successfully!!")
                        self.getPollListData(false)
                    }
                default:
                    DispatchQueue.main.async {
                        self.showAlertForError("Some Error has occured, try again!")
                    }
                }
            }
        })
        
        dataTask.resume()
    }
    
    func showAlertForError(_ message: String) -> (){
        let alert = UIAlertController(title: message, message: nil , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.opinionPollModelObject?.opinionPoll.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tempOpenionData = self.opinionPollModelObject?.opinionPoll[indexPath.row]{
            let votedUsersID = tempOpenionData.votedUserIds.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").components(separatedBy: ",")
            var votedUserIdInt: [Int] = []
            var switchCaseId = 0
            for value in votedUsersID{
                let stringArray = value.components(separatedBy: CharacterSet.decimalDigits.inverted)
                for item in stringArray {
                    if let number = Int(item) {
                        votedUserIdInt.append(number)
                    }
                }
            }
            if tempOpenionData.cellType == "0"{
                switchCaseId = votedUserIdInt.contains(loggedInUserId) ? 1 : 0
            }else{
                switchCaseId = 2
            }
            switch(switchCaseId){
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "opinionPollLiveVoteItTableViewCell") as! opinionPollLiveVoteItTableViewCell
                cell.alpha = 0
                cell.liveVoteBackgroundView.layer.cornerRadius = 10.0
                cell.subjectLabel.text = "Live: \(tempOpenionData.subject)"
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
                cell.liveVoteBackgroundView.giveBorder()
                UIView.animate(withDuration: 1) {
                    cell.alpha = 1.0
                }
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "opinionPollLiveVotedTableViewCell") as! opinionPollLiveVotedTableViewCell
                cell.alpha = 0
                cell.votedBackgroundView.layer.cornerRadius = 10.0
                cell.selectionStyle = .none
                cell.subjectLabel.text = "Live Voted: \(tempOpenionData.subject)"
                let getAnswersArray = (tempOpenionData.options).components(separatedBy: ",")
                cell.answerALabel.text = getAnswersArray.indices.contains(0) ? getAnswersArray[0] : ""
                cell.answerBLabel.text = getAnswersArray.indices.contains(1) ? getAnswersArray[1] : ""
                cell.answerCLabel.text = getAnswersArray.indices.contains(2) ? getAnswersArray[2] : ""
                cell.answerDLabel.text = getAnswersArray.indices.contains(3) ? getAnswersArray[3] : ""
                cell.votedBackgroundView.giveBorderWithColor(UIColor.green)
                let votedCountForOptionString = (tempOpenionData.voteCountList).replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").components(separatedBy: ",")
                var votedCountForOption: [Int] = []
                for value in votedCountForOptionString{
                    let stringArray = value.components(separatedBy: CharacterSet.decimalDigits.inverted)
                    for item in stringArray {
                        if let number = Int(item) {
                            votedCountForOption.append(number)
                        }
                    }
                }
                
                print("***VotedCount for Option")
                print("\(tempOpenionData.voteCountList)")
                print("\(votedCountForOption)")
                print("****")
                cell.answerAProgressBar.progress = 0
                cell.answerAProgressBar.progress = Float(votedCountForOption.indices.contains(0) ? votedCountForOption[0] : 0)
                cell.answerAVotePercenatge.text = "\(Int(votedCountForOption.indices.contains(0) ? votedCountForOption[0] : 0))"
                cell.answerBProgressBar.progress = 0
                cell.answerBProgressBar.progress = Float(votedCountForOption.indices.contains(1) ? votedCountForOption[1] : 0)
                cell.answerBVotePercentage.text = "\(Int(votedCountForOption.indices.contains(1) ? votedCountForOption[1] : 0) )"
                
                cell.answerCProgressBar.progress = 0
                cell.answerCProgressBar.progress = Float(votedCountForOption.indices.contains(2) ? votedCountForOption[2] : 0)
                cell.answerCVotePercentage.text = "\(Int(votedCountForOption.indices.contains(2) ? votedCountForOption[2] : 0))"
                
                cell.answerDProgressBar.progress = 0
                cell.answerDProgressBar.progress = Float(votedCountForOption.indices.contains(3) ? votedCountForOption[3] : 0)
                cell.answerDVotePercetage.text = "\(Int(votedCountForOption.indices.contains(3) ? votedCountForOption[3] : 0))"
                cell.endDateTimeLabel.text = "End Time: \(tempOpenionData.endDateTime)"
                UIView.animate(withDuration: 1) {
                    cell.alpha = 1.0
                }
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "opinionPollResultTableViewCell") as! opinionPollResultTableViewCell
                cell.alpha = 0
                cell.resultBackgoundView.layer.cornerRadius = 10.0
                cell.selectionStyle = .none
                
                
                //get the result
                let votedCountForOption = (tempOpenionData.voteCountList).components(separatedBy: ",")
                var wonCandidatesIndexs = ["1"]
                var tempHeighestVoteCount = Int(votedCountForOption[0]) ?? 0
                for (tempindex,tempVote) in votedCountForOption.enumerated(){
                    if Int(tempVote) ?? 0 > tempHeighestVoteCount{
                        wonCandidatesIndexs = ["\((tempindex + 1))"]
                        tempHeighestVoteCount = Int(tempVote) ?? 0
                    }else if Int(tempVote) ?? 0 == tempHeighestVoteCount{
                        wonCandidatesIndexs.append("\((tempindex + 1))")
                    }
                }
                var resultString = ""
                if wonCandidatesIndexs.count > 1{
//                    resultString = "The Poll is tied in between \(wonCandidatesIndexs.joined(separator:","))"
                    resultString = "No result, The Poll is tied"
                }else{
                    resultString = "Candidate at Position \(wonCandidatesIndexs.first ?? "1") won the poll"
                }
                cell.resultLabel.text = "Result: \(resultString)"
                
                
                
//                cell.resultLabel.text = "Result: \(tempOpenionData.result ?? "")"
                cell.subjectLabel.text = "Expire: \(tempOpenionData.subject)"
                let getAnswersArray = (tempOpenionData.options).components(separatedBy: ",")
                cell.answerALAbel.text = getAnswersArray.indices.contains(0) ? getAnswersArray[0] : ""
                cell.answerBLabel.text = getAnswersArray.indices.contains(1) ? getAnswersArray[1] : ""
                cell.answerCLabel.text = getAnswersArray.indices.contains(2) ? getAnswersArray[2] : ""
                cell.answreDLabel.text = getAnswersArray.indices.contains(3) ? getAnswersArray[3] : ""
                cell.resultBackgoundView.giveBorderWithColor(UIColor.green)
                
                print("***VotedCount for Option")
                print("\(tempOpenionData.voteCountList)")
                print("\(votedCountForOption)")
                print("****")
                
                cell.answerATotalVoteCount.text = "\(Int(votedCountForOption.indices.contains(0) ? votedCountForOption[0] : "") ?? 0)"
                cell.answerBTotalVoteCOunt.text = "\(Int(votedCountForOption.indices.contains(1) ? votedCountForOption[1] : "") ?? 0)"
                cell.answerCTotalVoteCount.text = "\(Int(votedCountForOption.indices.contains(2) ? votedCountForOption[2] : "") ?? 0)"
                cell.answerDTotalVoteCount.text = "\(Int(votedCountForOption.indices.contains(3) ? votedCountForOption[3] : "") ?? 0)"
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
