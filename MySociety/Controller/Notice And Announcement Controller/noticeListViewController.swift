//
//  noticeListViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class noticeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeListTableViewCell") as! NoticeListTableViewCell
        cell.alpha = 0
        let tempNotice = self.noticeList[indexPath.row]
        cell.noticeCellTitleLabel.text = tempNotice[0]
        cell.noticeCellDateTimeLabel.text = tempNotice[1]
        cell.noticeCellDescriptionLabel.text = tempNotice[2]
        cell.noticeCellBackgoundView.layer.cornerRadius = 10.0
        cell.selectionStyle = .none
        UIView.animate(withDuration: 1) {
            cell.alpha = 1.0
        }
        return cell
    }
    

}
