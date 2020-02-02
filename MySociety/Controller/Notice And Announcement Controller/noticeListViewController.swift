//
//  noticeListViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SDWebImage

class noticeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var noticeModel: notice?
    var selectedImageUrl = ""
    var noticeList: [[String]] = [["Tax Increment", "22/02/2020", "This is to inform you that we have incresed the functionality of what we were expecting for the circumtences."],["Position Increment", "29/03/2020", "This is to inform you that we have incresed the functionality of what we were expecting for the circumtences."],["Tax Increment", "22/02/2020", "This is to inform you that we have incresed the functionality of what we were expecting for the circumtences."],["Tax Increment", "22/02/2020", "This is to inform you that we have incresed the functionality of what we were expecting for the circumtences."],["Tax Increment", "22/02/2020", "This is to inform you that we have incresed the functionality of what we were expecting for the circumtences."]]
    @IBOutlet weak var noticeListTableView: UITableView!
    
    @IBOutlet weak var addNotice: UIButton!
    @IBAction func addNoticeAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "newNoticeAddSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noticeListTableView.estimatedRowHeight = 316
        self.noticeListTableView.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
        if !isAdminLoggedIn{
            self.addNotice.isHidden = true
        }
        getNoticeData()
    }
    
    func getNoticeData(){
        showSpinner(onView: self.view)
        let headerValues = globalHeaderValue
        let request = getRequestUrlWithHeader(url: "notice/\(loggedInUserId)", method: "GET", header: headerValues , bodyParams: nil)
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
                        self.noticeModel = try? JSONDecoder().decode(notice.self,from: data!)
                            DispatchQueue.main.sync {
                                self.noticeListTableView.reloadData()
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
    
    @objc func imgTap(tapGesture: UITapGestureRecognizer) {
           let imgView = tapGesture.view as! UIImageView
           let idToMove = imgView.tag
           print("\(idToMove)")
          //Do further execution where you need idToMove
        self.selectedImageUrl = "\(self.noticeModel?.noticeDatas[idToMove].imageUrl ?? "")"
        self.performSegue(withIdentifier: "noticeShowImageSegue", sender: self)

       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "noticeShowImageSegue") {
            let vc = segue.destination as! noticeShowImagePushPopOverViewController
            vc.tempImageUrl = "\(self.noticeModel?.imageBaseUrl ?? "")/\(self.selectedImageUrl)"
        }
    }
    
    func showAlert(_ message: String) -> (){
           let alert = UIAlertController(title: message, message: nil , preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: { _ in
            self.getNoticeData()
           }))
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
           }))
           self.present(alert, animated: true, completion: nil)
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noticeModel?.noticeDatas.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.noticeModel?.noticeDatas.indices.contains(indexPath.row) ?? false{
        let tempNotice = self.noticeModel?.noticeDatas[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeListTableViewCell") as! NoticeListTableViewCell
            cell.alpha = 0
            
            cell.noticeCellBackgoundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            cell.noticeCellTitleLabel.text = tempNotice?.title ?? ""
            cell.noticeCellDateTimeLabel.text = tempNotice?.date ?? ""
            cell.noticeCellDescriptionLabel.text = tempNotice?.description ?? ""
            
            cell.noticeCellImageView.tag = indexPath.row
            let tapGesture = UITapGestureRecognizer (target: self, action: #selector(imgTap(tapGesture:)))
            cell.noticeCellImageView.addGestureRecognizer(tapGesture)
            cell.noticeCellImageView.isUserInteractionEnabled = true
//            cell.noticeCellImageView.cornerRadius(radius: 10.0)
            cell.noticeCellImageView.layer.cornerRadius = 10.0
            let imageURL = URL(string: "\(self.noticeModel?.imageBaseUrl ?? "")/\(tempNotice?.imageUrl ?? "")")
            //            myImageView.contentMode = UIView.ContentMode.scaleToFill
            cell.noticeCellImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named:"building"))
            
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeListTableViewCell") as! NoticeListTableViewCell
            cell.alpha = 0
            
            cell.noticeCellBackgoundView.layer.cornerRadius = 10.0
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }
    }

}
