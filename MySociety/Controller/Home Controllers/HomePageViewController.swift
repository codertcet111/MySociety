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
    var tempVarData: [[String]] = [["1", "Upcoming Election", "This is for those to vote on the knwoldge center, Those intereseted into this election may cast their vote in the pallet box appearing in the front of the box.", "2019-09-19 at 02:20 AM", "2020-09-19 at 12:20 AM"],["2", "Notice", "Notice for the period cange in the description of the world. Now as we can see the trump administration is not serious.", "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.zoho.com%2Finvoice%2Fwhat-is-invoice%2Frecurring-invoice.png&imgrefurl=https%3A%2F%2Fwww.zoho.com%2Finvoice%2Fwhat-is-invoice%2F&docid=3C4dskUuxNNBYM&tbnid=pq6vf9MSBGHfoM%3A&vet=10ahUKEwiyq_G9_frmAhXm7HMBHQVlC2wQMwh5KAMwAw..i&w=1073&h=1519&client=safari&bih=769&biw=1360&q=invoice&ved=0ahUKEwiyq_G9_frmAhXm7HMBHQVlC2wQMwh5KAMwAw&iact=mrc&uact=8"], ["0", "Video", "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"], ["3", "Election Result", "This is for those to vote on the knwoldge center, Those intereseted into this election may cast their vote in the pallet box appearing in the front of the box.", "Yeah, Mr. Ganesh has won the secretory election"], ["4", "Live Poll", "This is to select the right place for upcoming Gym, Those intereseted into this election may cast their vote in the pallet box appearing in the front of the box."], ["5", "Poll Result", "This is to select the right place for upcoming Gym, You might be wondering for this selection.", "Yeah the new position will be next to the circulation of upcoming gymnasium"], ["6", "Event", "2019-09-19 at 02:20 AM", "For the Birthday of Mr. Ganesh"], ["7", "Live Election", "This is for those to vote on the knwoldge center"], ["1", "Upcoming Election", "This is for those to vote on the knwoldge center, Those intereseted into this election may cast their vote in the pallet box appearing in the front of the box.", "2019-09-19 at 02:20 AM", "2020-09-19 at 12:20 AM"],["2", "Notice", "Notice for the period cange in the description of the world. Now as we can see the trump administration is not serious.", "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.zoho.com%2Finvoice%2Fwhat-is-invoice%2Frecurring-invoice.png&imgrefurl=https%3A%2F%2Fwww.zoho.com%2Finvoice%2Fwhat-is-invoice%2F&docid=3C4dskUuxNNBYM&tbnid=pq6vf9MSBGHfoM%3A&vet=10ahUKEwiyq_G9_frmAhXm7HMBHQVlC2wQMwh5KAMwAw..i&w=1073&h=1519&client=safari&bih=769&biw=1360&q=invoice&ved=0ahUKEwiyq_G9_frmAhXm7HMBHQVlC2wQMwh5KAMwAw&iact=mrc&uact=8"], ["0", "Video", "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"], ["3", "Election Result", "This is for those to vote on the knwoldge center, Those intereseted into this election may cast their vote in the pallet box appearing in the front of the box.", "Yeah, Mr. Ganesh has won the secretory election"], ["4", "Live Poll", "This is to select the right place for upcoming Gym, Those intereseted into this election may cast their vote in the pallet box appearing in the front of the box."], ["5", "Poll Result", "This is to select the right place for upcoming Gym, You might be wondering for this selection.", "Yeah the new position will be next to the circulation of upcoming gymnasium"], ["6", "Event", "2019-09-19 at 02:20 AM", "For the Birthday of Mr. Ganesh"], ["7", "Live Election", "This is for those to vote on the knwoldge center"]]
    let cellsName: [String] = ["videoHomePageTableViewCell", "upcomingElectionHomePageTableViewCell", "noticeHomePageTableViewCell", "electionResultsHomePageTableViewCell", "livePollHomepgeTableViewCell", "pollResultHomePageTableViewCell", "eventHomePageTableViewCell", "liveElectionHomePageTableViewCell"]
    
    var homePageModel: homePage?
    var homePagevideoCount: Int = 0
    var homePageUpcomingElectionCount: Int = 0
    var homePageNoticeCount: Int = 0
    var homePageElectionResultCount: Int = 0
    var homePageLivePollCount: Int = 0
    var homePagePollResultCount: Int = 0
    var homePageEventCount: Int = 0
    var homePageLiveElectionCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUiView()
        self.homeFeedViewController.estimatedRowHeight = 180
        self.homeFeedViewController.rowHeight = UITableView.automaticDimension
        self.getHomeData()
    }
    
    func setUiView(){
        
    }
    
    func getHomeData(){
        showSpinner(onView: self.view)
        let headerValues = globalHeaderValue
        let request = getRequestUrlWithHeader(url: "home/\(loggedInUserId)", method: "GET", header: headerValues , bodyParams: nil)
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
                        self.homePageModel = try? JSONDecoder().decode(homePage.self,from: data!)
                            DispatchQueue.main.sync{
                                self.homePagevideoCount = self.homePageModel?.feed.videoHome.count ?? 0
                                self.homePageUpcomingElectionCount = self.homePageModel?.feed.upcomingElectionHome.count ?? 0
                                self.homePageNoticeCount = self.homePageModel?.feed.notice.count ?? 0
                                self.homePageElectionResultCount = self.homePageModel?.feed.electionResultHome.count ?? 0
                                self.homePageLivePollCount = self.homePageModel?.feed.livePolHome.count ?? 0
                                self.homePagePollResultCount = self.homePageModel?.feed.pollResultHome.count ?? 0
                                self.homePageEventCount = self.homePageModel?.feed.eventHome.count ?? 0
                                self.homePageLiveElectionCount = self.homePageModel?.feed.electionResultHome.count ?? 0
                                self.homeFeedViewController.reloadData()
                            }
                    case 401:
                         DispatchQueue.main.sync {
                            self.showAlert("Unauthorized User")
                        }
                    default:
                         DispatchQueue.main.sync {
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
         self.getHomeData()
        }))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (homePagevideoCount + homePageUpcomingElectionCount + homePageNoticeCount + homePageElectionResultCount + homePageLivePollCount + homePagePollResultCount + homePageEventCount + homePageLiveElectionCount)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let tempData = tempVarData[indexPath.row]
        if self.homePagevideoCount > (indexPath.row){
            let cell = tableView.dequeueReusableCell(withIdentifier: "videoHomePageTableViewCell") as! videoHomePageTableViewCell
            let tempVideoData = self.homePageModel?.feed.videoHome[indexPath.row]
            cell.alpha = 0
            cell.videoTitleLabel.text = tempVideoData?.title ?? ""
            cell.timeStampDateLabel.text = tempVideoData?.date ?? ""
            cell.Id = tempVideoData?.destinationId ?? 0
            let url = NSURL(string: tempVideoData?.videoUrl ?? "")
            let avPlayer = AVPlayer(url: url! as URL);
            cell.videoView.playerLayer.player = avPlayer;
            cell.videoBackgroundView.layer.cornerRadius = 10.0
            cell.videoView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }else if ((self.homePageUpcomingElectionCount + self.homePagevideoCount) > (indexPath.row)){
            let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingElectionHomePageTableViewCell") as! upcomingElectionHomePageTableViewCell
            cell.alpha = 0
            let tempUpcomingElectionData = self.homePageModel?.feed.upcomingElectionHome[indexPath.row - (self.homePagevideoCount)]
            cell.upcomingElectionTitle.text = tempUpcomingElectionData?.title ?? ""
            cell.upcomingElectionDescriptionLabel.text = tempUpcomingElectionData?.description ?? ""
            cell.upcomingElectionStartDateLAbel.text = "Start: \(tempUpcomingElectionData?.startDate ?? "")"
            cell.upcomingElectionEndDateLabel.text = "End: \(tempUpcomingElectionData?.endDate ?? "")"
            cell.Id = tempUpcomingElectionData?.destinationId ?? 0
            cell.timeStampDateLabel.text = tempUpcomingElectionData?.date ?? ""
            cell.upcomingElectionBackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }else if ((self.homePageNoticeCount + self.homePagevideoCount + self.homePageUpcomingElectionCount) > (indexPath.row)){
            let cell = tableView.dequeueReusableCell(withIdentifier: "noticeHomePageTableViewCell") as! noticeHomePageTableViewCell
            cell.alpha = 0
            let tempBoticeData = self.homePageModel?.feed.notice[indexPath.row - (self.homePagevideoCount + self.homePageUpcomingElectionCount)]
            cell.noticeTitleLabel.text = tempBoticeData?.title ?? ""
            cell.noticeDescriptionLabel.text = tempBoticeData?.description ?? ""
            cell.Id = tempBoticeData?.destinationId ?? 0
            cell.timeStampDateLabel.text = tempBoticeData?.date ?? ""
            cell.noticeBackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            Alamofire.request("\(tempBoticeData?.image ?? "")")
            .responseImage { response in

                if let image = response.result.value {
                    cell.imageView?.image = image
                }
            }
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }else if ((self.homePageElectionResultCount + self.homePagevideoCount + self.homePageUpcomingElectionCount + self.homePageNoticeCount) > (indexPath.row)){
            let cell = tableView.dequeueReusableCell(withIdentifier: "electionResultsHomePageTableViewCell") as! electionResultsHomePageTableViewCell
            cell.alpha = 0
            let tempElectionData = self.homePageModel?.feed.electionResultHome[indexPath.row - (self.homePagevideoCount + self.homePageUpcomingElectionCount + self.homePageNoticeCount)]
            cell.electionResultTitleLabel.text = tempElectionData?.title ?? ""
            cell.electionResultDescriptionLabel.text = tempElectionData?.description ?? ""
            cell.electionResultResultLabel.text = tempElectionData?.result ?? ""
            cell.timeStampDateLabel.text = tempElectionData?.date ?? ""
            cell.Id = tempElectionData?.destinationId ?? 0
            cell.electionResultBackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }else if ((self.homePageLivePollCount + self.homePagevideoCount + self.homePageUpcomingElectionCount + self.homePageNoticeCount + self.homePageElectionResultCount) > (indexPath.row)){
            let cell = tableView.dequeueReusableCell(withIdentifier: "livePollHomepgeTableViewCell") as! livePollHomepgeTableViewCell
            cell.alpha = 0
            let templivePollData = self.homePageModel?.feed.livePolHome[indexPath.row - (self.homePagevideoCount + self.homePageUpcomingElectionCount + self.homePageNoticeCount + self.homePageElectionResultCount)]
            cell.livePolltitleLabel.text = templivePollData?.title ?? ""
            cell.livePollDescriptionLabel.text = templivePollData?.description ?? ""
            cell.timeStampDateLabel.text = templivePollData?.date ?? ""
            cell.Id = templivePollData?.destinationId ?? 0
            cell.livePollBackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }else if ((self.homePagePollResultCount  + self.homePagevideoCount + self.homePageUpcomingElectionCount + self.homePageNoticeCount + self.homePageElectionResultCount + self.homePageLivePollCount) > (indexPath.row)){
            let cell = tableView.dequeueReusableCell(withIdentifier: "pollResultHomePageTableViewCell") as! pollResultHomePageTableViewCell
            cell.alpha = 0
            let temppollResultData = self.homePageModel?.feed.pollResultHome[indexPath.row - (self.homePagevideoCount + self.homePageUpcomingElectionCount + self.homePageNoticeCount + self.homePageElectionResultCount + self.homePageLivePollCount)]
            cell.pollResultTitleLabel.text = temppollResultData?.title ?? ""
            cell.pollResultDesriptionLabel.text = temppollResultData?.description ?? ""
            cell.pollResultResultLabel.text = temppollResultData?.result ?? ""
            cell.timeStampDateLabel.text = temppollResultData?.date ?? ""
            cell.Id = temppollResultData?.destinationId ?? 0
            cell.pollResultBackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }else if ((self.homePageEventCount + self.homePagevideoCount + self.homePageUpcomingElectionCount + self.homePageNoticeCount + self.homePageElectionResultCount + self.homePageLivePollCount + self.homePagePollResultCount) > (indexPath.row)){
            let cell = tableView.dequeueReusableCell(withIdentifier: "eventHomePageTableViewCell") as! eventHomePageTableViewCell
            cell.alpha = 0
            let tempEventData = self.homePageModel?.feed.eventHome[indexPath.row - (self.homePagevideoCount + self.homePageUpcomingElectionCount + self.homePageNoticeCount + self.homePageElectionResultCount + self.homePageLivePollCount + self.homePagePollResultCount)]
            cell.eventHomeTitleLabekl.text = tempEventData?.title ?? ""
            cell.eventHomeDateTimeLabel.text = tempEventData?.date ?? ""
            cell.eventHomeDescriptionLabel.text = tempEventData?.description ?? ""
            cell.timeStampDateLabel.text = tempEventData?.date ?? ""
            cell.Id = tempEventData?.destinationId ?? 0
            cell.evetnHomeackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }else if ((self.homePageLiveElectionCount + self.homePagevideoCount + self.homePageUpcomingElectionCount + self.homePageNoticeCount + self.homePageElectionResultCount + self.homePageLivePollCount + self.homePagePollResultCount + self.homePageEventCount) > (indexPath.row)){
            let cell = tableView.dequeueReusableCell(withIdentifier: "liveElectionHomePageTableViewCell") as! liveElectionHomePageTableViewCell
            cell.alpha = 0
            let tempLiveElectionData = self.homePageModel?.feed.liveElectionHome[indexPath.row - (self.homePagevideoCount + self.homePageUpcomingElectionCount + self.homePageNoticeCount + self.homePageElectionResultCount + self.homePageLivePollCount + self.homePagePollResultCount + self.homePageEventCount)]
            cell.liveElectionTitleLabel.text = tempLiveElectionData?.title ?? ""
            cell.liveElectionDescriptionLabel.text = tempLiveElectionData?.description ?? ""
            cell.timeStampDateLabel.text = tempLiveElectionData?.date ?? ""
            cell.Id = tempLiveElectionData?.destinationId ?? 0
            cell.liveElectionBackgroundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }else{
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
        if self.homePagevideoCount > (indexPath.row){
            let cell = tableView.dequeueReusableCell(withIdentifier: "videoHomePageTableViewCell") as! videoHomePageTableViewCell
            let visibleCells = tableView.visibleCells;
            let minIndex = visibleCells.startIndex;
            if tableView.visibleCells.firstIndex(of: cell) == minIndex {
                cell.videoView.player?.play()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.homePagevideoCount > (indexPath.row){
            let cell = tableView.dequeueReusableCell(withIdentifier: "videoHomePageTableViewCell") as! videoHomePageTableViewCell
            cell.videoView.player?.pause();
            cell.videoView.player = nil;
        }
    }
}

