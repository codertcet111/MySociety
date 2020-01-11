//
//  HomePageViewController.swift
//  MySociety
//
//  Created by Admin on 09/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Alamofire
import AlamofireImage


class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var homeFeedViewController: UITableView!
    //Below it will be like, [type, title, date, start_date, end_date,  video_url, description, destination_id, Result]
    var tempVarData: [[String]] = [["0", "Video", "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"],["1", "Upcoming Election", "This is for those to vote on the knwoldge center", "2019/09/19 at 02:20 AM", "2020/09/19 at 12:20 AM"],["2", "Notice", "Notice for the period cange in the description of the world", "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.zoho.com%2Finvoice%2Fwhat-is-invoice%2Frecurring-invoice.png&imgrefurl=https%3A%2F%2Fwww.zoho.com%2Finvoice%2Fwhat-is-invoice%2F&docid=3C4dskUuxNNBYM&tbnid=pq6vf9MSBGHfoM%3A&vet=10ahUKEwiyq_G9_frmAhXm7HMBHQVlC2wQMwh5KAMwAw..i&w=1073&h=1519&client=safari&bih=769&biw=1360&q=invoice&ved=0ahUKEwiyq_G9_frmAhXm7HMBHQVlC2wQMwh5KAMwAw&iact=mrc&uact=8"], ["3", "Election Result", "This is for those to vote on the knwoldge center", "Yeah, Mr. Ganesh has won the secretory election"], ["4", "Live Poll", "This is to select the right place for upcoming Gym"], ["5", "Poll Result", "This is to select the right place for upcoming Gym", "Yeah the new position will be next to the circulation of upcoming gymnasium"], ["6", "Event", "2019/09/19 at 02:20 AM", "For the Birthday of Mr. Ganesh"], ["7", "Live Election", "This is for those to vote on the knwoldge center"]]
    let cellsName: [String] = ["videoHomePageTableViewCell", "upcomingElectionHomePageTableViewCell", "noticeHomePageTableViewCell", "electionResultsHomePageTableViewCell", "livePollHomepgeTableViewCell", "pollResultHomePageTableViewCell", "eventHomePageTableViewCell", "liveElectionHomePageTableViewCell"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUiView()
    }
    
    func setUiView(){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempVarData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempData = tempVarData[indexPath.row]
        switch(tempData[0]){
        case "0":
            let cell = tableView.dequeueReusableCell(withIdentifier: "videoHomePageTableViewCell") as! videoHomePageTableViewCell
            cell.alpha = 0
            cell.videoTitleLabel.text = tempData[1]
            let url = NSURL(string: tempData[2]);
            let avPlayer = AVPlayer(url: url! as URL);
            cell.videoView.playerLayer.player = avPlayer;
            cell.videoBackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        case "1":
            let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingElectionHomePageTableViewCell") as! upcomingElectionHomePageTableViewCell
            cell.alpha = 0
            cell.upcomingElectionTitle.text = tempData[1]
            cell.upcomingElectionDescriptionLabel.text = tempData[2]
            cell.upcomingElectionStartDateLAbel.text = tempData[3]
            cell.upcomingElectionEndDateLabel.text = tempData[4]
            cell.upcomingElectionBackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        case "2":
            let cell = tableView.dequeueReusableCell(withIdentifier: "noticeHomePageTableViewCell") as! noticeHomePageTableViewCell
            cell.alpha = 0
            cell.noticeTitleLabel.text = tempData[1]
            cell.noticeDescriptionLabel.text = tempData[2]
            cell.noticeBackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            Alamofire.request("\(tempData[3])")
            .responseImage { response in

                if let image = response.result.value {
                    cell.imageView?.image = image
                }
            }
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        case "3":
            let cell = tableView.dequeueReusableCell(withIdentifier: "electionResultsHomePageTableViewCell") as! electionResultsHomePageTableViewCell
            cell.alpha = 0
            cell.electionResultTitleLabel.text = tempData[1]
            cell.electionResultDescriptionLabel.text = tempData[2]
            cell.electionResultResultLabel.text = tempData[3]
            cell.electionResultBackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        case "4":
            let cell = tableView.dequeueReusableCell(withIdentifier: "livePollHomepgeTableViewCell") as! livePollHomepgeTableViewCell
            cell.alpha = 0
            cell.livePolltitleLabel.text = tempData[1]
            cell.livePollDescriptionLabel.text = tempData[2]
            cell.livePollBackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        case "5":
            let cell = tableView.dequeueReusableCell(withIdentifier: "pollResultHomePageTableViewCell") as! pollResultHomePageTableViewCell
            cell.alpha = 0
            cell.pollResultTitleLabel.text = tempData[1]
            cell.pollResultDesriptionLabel.text = tempData[2]
            cell.pollResultResultLabel.text = tempData[3]
            cell.pollResultBackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        case "6":
            let cell = tableView.dequeueReusableCell(withIdentifier: "eventHomePageTableViewCell") as! eventHomePageTableViewCell
            cell.alpha = 0
            cell.eventHomeTitleLabekl.text = tempData[1]
            cell.eventHomeDateTimeLabel.text = tempData[2]
            cell.eventHomeDescriptionLabel.text = tempData[3]
            cell.evetnHomeackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        case "7":
            let cell = tableView.dequeueReusableCell(withIdentifier: "liveElectionHomePageTableViewCell") as! liveElectionHomePageTableViewCell
            cell.alpha = 0
            cell.liveElectionTitleLabel.text = tempData[1]
            cell.liveElectionDescriptionLabel.text = tempData[2]
            cell.liveElectionBackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "liveElectionHomePageTableViewCell") as! liveElectionHomePageTableViewCell
            cell.alpha = 0
            cell.liveElectionBackgroundView.layer.cornerRadius = 10.0
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let tempData = tempVarData[indexPath.row]
        if tempData[0] == "0"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "videoHomePageTableViewCell") as! videoHomePageTableViewCell
            let visibleCells = tableView.visibleCells;
            let minIndex = visibleCells.startIndex;
            if tableView.visibleCells.firstIndex(of: cell) == minIndex {
                cell.videoView.player?.play()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let tempData = tempVarData[indexPath.row]
        if tempData[0] == "0"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "videoHomePageTableViewCell") as! videoHomePageTableViewCell
            cell.videoView.player?.pause();
            cell.videoView.player = nil;
        }
    }
}

