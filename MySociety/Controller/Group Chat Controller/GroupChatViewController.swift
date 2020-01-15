//
//  GroupChatViewController.swift
//  MySociety
//
//  Created by Admin on 15/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class GroupChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var groupChatTableView: UITableView!
    @IBOutlet weak var postBtn: UIButton!
    @IBAction func postBtnAction(_ sender: UIButton) {
        
    }
    @IBOutlet weak var typeMessageTextField: UITextField!
    @IBOutlet weak var groupChatMessageTypeView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.groupChatTableView.estimatedRowHeight = 164
        self.groupChatTableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.row){
        case 0, 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "groupChatOthersCHatTableViewCell") as! groupChatOthersCHatTableViewCell
            cell.alpha = 0
            cell.otherChatBackgroundView.layer.cornerRadius = 10
            
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        case 1, 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCHatMyCHatTableViewCell") as! GroupCHatMyCHatTableViewCell
            cell.alpha = 0
            cell.myChatBackgroundView.layer.cornerRadius = 10
            
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "groupChatOthersCHatTableViewCell") as! groupChatOthersCHatTableViewCell
            cell.alpha = 0
            cell.otherChatBackgroundView.layer.cornerRadius = 10
            
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }
    }
    
    

}
