//
//  MemberDirectoryListViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MemberDirectoryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tempMemberDirectoryListArray:[[String]] = [["Secretory","Rahul Dubey","7383822348","rahul.dubey@gmail.com"], ["","Gaurav Panchal","7383822348","rahul.dubey@gmail.com"], ["Trasurer","Govinda Tib","7383822348","rahul.dubey@gmail.com"], ["","Rahul Dubey","7383822348","rahul.dubey@gmail.com"]]
    @IBOutlet weak var memberDirectoryListTableView: UITableView!
    
    @IBAction func makePositionChangeAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "changeMemberSegue", sender: self)
    }
    @IBOutlet weak var makePositionChangeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.memberDirectoryListTableView.layer.cornerRadius = 10
        self.makePositionChangeBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempMemberDirectoryListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberDirectoryListTableViewCell") as! MemberDirectoryListTableViewCell
        cell.alpha = 0
        let tempMemberDirectory = tempMemberDirectoryListArray[indexPath.row]
        cell.memberDIrectoryCellPositionLabel.text = tempMemberDirectory[0]
        cell.memebrDirectoryMobileNumberlabel.text = tempMemberDirectory[2]
        cell.memberDirectoryUserEmailIDLabel.text = tempMemberDirectory[3]
        cell.memberDirectoryuserNameLabel.text = tempMemberDirectory[1]
        cell.memberDirectoryBackgroundView.layer.cornerRadius = 10
        UIView.animate(withDuration: 1) {
            cell.alpha = 1.0
        }
        return cell
    }

}
