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
    var electionListModel: ElectionList?
    @IBAction func addElectionBtnAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "newElectionFromListSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.electionListTableView.estimatedRowHeight = 325
        self.electionListTableView.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
        if !isAdminLoggedIn{
            self.addElectionBtn.isHidden = true
            
        }
    }
    
    var isFirstLoad: Bool = true
    override func viewWillAppear(_ animated: Bool) {
        self.getElectionListData(self.isFirstLoad)
        self.isFirstLoad = false
    }
    
    func getElectionListData(_ showSpinnerTemp: Bool){
        if showSpinnerTemp{
            showSpinner(onView: self.view)
        }
        let headerValues = globalHeaderValue
        let request = getRequestUrlWithHeader(url: "election/\(loggedInUserId)", method: "GET", header: headerValues , bodyParams: nil)
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
                        self.electionListModel = try? JSONDecoder().decode(ElectionList.self,from: data!)
                            DispatchQueue.main.sync {
                                self.electionListTableView.reloadData()
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
            self.getElectionListData(true)
           }))
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
           }))
           self.present(alert, animated: true, completion: nil)
       }
    
    
    func voteForElection(_ electionId: Int,_ optionIndex: Int){
        self.showSpinner(onView: self.view)
        let parameters = [
            "election_id": electionId,
            "selected_option_index": optionIndex,
            "user_id": "\(loggedInUserId)"
            ] as [String : Any]
        let headerValues = ["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"]
        let request = getRequestUrlWithHeader(url: "electionvote", method: "POST", header: headerValues, bodyParams: parameters)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.removeSpinner()
            }
            if (error != nil) {
                print(error ?? "")
            } else {
                let httpResponse = response as? HTTPURLResponse
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Body: \(String(describing: strData))")
                
                switch(httpResponse?.statusCode ?? 201){
                case 200, 201:
                    DispatchQueue.main.async {
                        self.showAlertForError("Voted Successfully!!")
                        self.getElectionListData(false)
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
    
    
    @objc func voteButtonAction(sender:UIButton)
    {
        print("You have selected")
        var senderTag = sender.tag
        let tempSenderTag = sender.tag
//        print("\(self.electionListModel?.electionData[lasttwoDigits].)")
        print("selected button position")
        print("\(Int("\(senderTag)".suffix(2)) ?? 0)")
        senderTag = senderTag - (Int("\(senderTag)".suffix(2)) ?? 0)
        var electionCellIndex = 0
        if senderTag == 0{
            electionCellIndex = 0
        }else{
            electionCellIndex = senderTag/1000
        }
        print("Selected cell position")
        print("\(electionCellIndex)")
        self.voteForElection(self.electionListModel?.electionData[electionCellIndex].electionId ?? 0, Int("\(tempSenderTag)".suffix(2)) ?? 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 999{
            return self.electionListModel?.electionData.count ?? 0
        }else{
            //THis will be the inside table's cells items, so u can use the tableview.tag for getting correct data, index position
            if self.electionListModel?.electionData.indices.contains(tableView.tag) ?? false{
                let optionsArray = self.electionListModel?.electionData[tableView.tag].optionsList.components(separatedBy: ",")
                return optionsArray?.count ?? 0
            }else{
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 999{
            if self.electionListModel?.electionData.indices.contains(indexPath.row) ?? false{
                let tempElectionData = self.electionListModel?.electionData[indexPath.row]
                switch(tempElectionData?.cellType){
                    case "1":
                        let cell = tableView.dequeueReusableCell(withIdentifier: "liveElectionListTableViewCell") as! liveElectionListTableViewCell
                        //NOTE: Cell's vote Btn show and enable if not voted at, else show till vote count for each options
                        cell.alpha = 0
                        cell.liveElectionListBackgroundView.layer.cornerRadius = 10
        //                cell.electionInsideTableViewHeight.constant = 60 * (numberOfOptionsInsideElection)
                        let optionsArray = self.electionListModel?.electionData[indexPath.row].optionsList.components(separatedBy: ",")
                        cell.electionInsideTableViewHeight.constant = CGFloat(60.0 * Float(optionsArray?.count ?? 0))
                        
                        cell.electionInsideTableView.tag = indexPath.row
                        //                        cell.electionInsideTableView.tag = insideTableViewTagCount
//                        insideTableViewTagCount += 1
                        
                        let votedUsersID = self.electionListModel?.electionData[indexPath.row].isVoted.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").components(separatedBy: ",") ?? []
                        var votedUserIdInt: [Int] = []
                        for value in votedUsersID{
                            let stringArray = value.components(separatedBy: CharacterSet.decimalDigits.inverted)
                            for item in stringArray {
                                if let number = Int(item) {
                                    votedUserIdInt.append(number)
                                }
                            }
                        }
                        cell.electionInsideTableView.reloadData()
                        
                        print("*** VotedUserId")
                        print("\(indexPath.row)")
                        print("\(self.electionListModel?.electionData[indexPath.row].isVoted ?? "")")
                        print("\(votedUserIdInt)")
                        
                        if votedUserIdInt.contains(loggedInUserId){
                            cell.liveElectionListBackgroundView.giveBorderWithColor(UIColor.green)
                        }else{
                            cell.liveElectionListBackgroundView.giveBorderWithColor(UIColor.red)
                        }
                        cell.selectionStyle = .none
                        cell.subjectLabel.text = "Live: \(tempElectionData?.subject ?? "")"
                        UIView.animate(withDuration: 1) {
                            cell.alpha = 1.0
                        }
                        return cell
                    case "0":
                        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingElectionTableViewCell") as! UpcomingElectionTableViewCell
                        cell.alpha = 0
                        cell.upcomingElectionBackgroundView.layer.cornerRadius = 10
                        cell.selectionStyle = .none
                        cell.upcomingElectionSubject.text = "Upcoming : \(tempElectionData?.subject ?? "")"
                        cell.upcomingElectionComingDateTime.text = "Start Time: \(tempElectionData?.startDateTime ?? "")"
                        cell.upcomingElectionBackgroundView.giveBorderWithColor(UIColor.green)
                        UIView.animate(withDuration: 1) {
                            cell.alpha = 1.0
                        }
                        return cell
                    case "2":
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultElectionListTableViewCell") as! ResultElectionListTableViewCell
                        cell.alpha = 0
                        cell.resultElectionBackgroundView.layer.cornerRadius = 10
                        cell.selectionStyle = .none
                        cell.resultElectionSubject.text = tempElectionData?.subject ?? ""
                        
                        
                        
                        //get the result
                        let votedCountForOptionString = ((self.electionListModel?.electionData[indexPath.row])?.voteCountList)?.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").components(separatedBy: ",") ?? []
                        var votedCountForOption: [Int] = []
                        for value in votedCountForOptionString{
                            let stringArray = value.components(separatedBy: CharacterSet.decimalDigits.inverted)
                            for item in stringArray {
                                if let number = Int(item) {
                                    votedCountForOption.append(number)
                                }
                            }
                        }
                        let optionsForElection = ((self.electionListModel?.electionData[indexPath.row])?.optionsList ?? "").components(separatedBy: ",")
                        var wonCandidatesIndexs = [0]
                        var tempHeighestVoteCount = votedCountForOption[0]
                        for (tempindex,tempVote) in votedCountForOption.enumerated(){
                            if tempVote > tempHeighestVoteCount{
                                wonCandidatesIndexs = [tempindex]
                                tempHeighestVoteCount = tempVote
                            }else if tempVote == tempHeighestVoteCount{
                                wonCandidatesIndexs.append(tempindex)
                            }
                        }
                        var resultString = ""
                        if wonCandidatesIndexs.count > 1{
        //                    resultString = "The Poll is tied in between \(wonCandidatesIndexs.joined(separator:","))"
                            resultString = "No result, The Election is tied for "
                            for tempResult in wonCandidatesIndexs{
                                resultString.append(": \(optionsForElection.indices.contains(tempResult) ? optionsForElection[tempResult] : "")")
                            }
                        }else{
                            resultString = "\(optionsForElection.indices.contains(wonCandidatesIndexs.first ?? 0) ? optionsForElection[wonCandidatesIndexs.first ?? 0] : "") won the Election"
                        }
                        cell.resultElectionResult.text = "Result: \(resultString)"
                        
                        
                        
                        
//                        cell.resultElectionResult.text = "Result: \(tempElectionData?.result ?? "")"
                        cell.resultElectionBackgroundView.giveBorder()
                        cell.resultELectionEndedOn.text = "Ended: \(tempElectionData?.endDateTime ?? "")"
                        UIView.animate(withDuration: 1) {
                            cell.alpha = 1.0
                        }
                        cell.resultElectionBackgroundView.giveBorderWithColor(UIColor.green)
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "ResultElectionListTableViewCell") as! ResultElectionListTableViewCell
                cell.alpha = 0
                cell.selectionStyle = .none
                UIView.animate(withDuration: 1) {
                    cell.alpha = 1.0
                }
                return cell
            }
        }else{
            //Inside's Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "ElectionLiveInsideTableViewCell") as! ElectionLiveInsideTableViewCell
            cell.alpha = 0
            cell.selectionStyle = .none
//            print(tableView.tag)
//            print(cell.electionOptionsLabel.text)
            let votedUsersID = (self.electionListModel?.electionData[tableView.tag])?.isVoted.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").components(separatedBy: ",") ?? []
            var votedUserIdInt: [Int] = []
            for value in votedUsersID{
                let stringArray = value.components(separatedBy: CharacterSet.decimalDigits.inverted)
                for item in stringArray {
                    if let number = Int(item) {
                        votedUserIdInt.append(number)
                    }
                }
            }
            
            print("*** VotedUserId Inside the cell")
//            print("\(indexPath.row)")
//            print("\(self.electionListModel?.electionData[indexPath.row].isVoted ?? "")")
//            print("\(votedUserIdInt)")
            
            if votedUserIdInt.contains(loggedInUserId){
                if self.electionListModel?.electionData.indices.contains(tableView.tag) ?? false{
                    if (self.electionListModel?.electionData[tableView.tag])?.voteCountList != nil{
                        
                        let votedCountForOptionString = ((self.electionListModel?.electionData[tableView.tag])?.voteCountList)?.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").components(separatedBy: ",") ?? []
                        var votedCountForOption: [Int] = []
                        for value in votedCountForOptionString{
                            let stringArray = value.components(separatedBy: CharacterSet.decimalDigits.inverted)
                            for item in stringArray {
                                if let number = Int(item) {
                                    votedCountForOption.append(number)
                                }
                            }
                        }
                        
                        print("*** VotedCount list")
                        print("\(tableView.tag)")
                        print("\(self.electionListModel?.electionData[tableView.tag].voteCountList ?? "")")
                        print("\(votedCountForOption)")
                        print("Index Path: \(indexPath.row)")
                        
                        if votedCountForOption.indices.contains(indexPath.row){
                            cell.electionOptionVoteBtn.setTitle("\(votedCountForOption[indexPath.row])", for: .normal)
                        }else{
                            cell.electionOptionVoteBtn.setTitle("0", for: .normal)
                        }
                        
                    }else{
                        cell.electionOptionVoteBtn.setTitle("0", for: .normal)
                    }
                }else{
                    cell.electionOptionVoteBtn.setTitle("0", for: .normal)
                }
            }else{
                cell.electionOptionVoteBtn.tag = (1000 * tableView.tag + indexPath.row)
                cell.electionOptionVoteBtn.addTarget(self, action: #selector(voteButtonAction(sender:)), for: .touchUpInside)
            }
            if self.electionListModel?.electionData.indices.contains(tableView.tag) ?? false{
                if (self.electionListModel?.electionData[tableView.tag])?.optionsList != nil{
                    let optionsArray = (self.electionListModel?.electionData[tableView.tag])?.optionsList.components(separatedBy: ",")
                    if optionsArray?.indices.contains(indexPath.row) ?? false{
                        cell.electionOptionsLabel.text = optionsArray?[indexPath.row] ?? ""
                    }else{
                        cell.electionOptionsLabel.text = "No Option"
                    }
                }else{
                    cell.electionOptionsLabel.text = "No Option"
                }
            }else{
                cell.electionOptionsLabel.text = "No Option"
            }
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }
    }
}
