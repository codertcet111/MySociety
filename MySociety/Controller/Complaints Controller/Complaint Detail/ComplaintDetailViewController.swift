//
//  ComplaintDetailViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ComplaintDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    //0: For me, 1: For front one walas
    var complaintsChatData = [["The problem is persistent, still I cannot find out the way?","URL","0"], ["The problem is persistent, still I cannot find out the way?","URL","1"],["The problem is persistent, still I cannot find out the way?","URL","0"],["The problem is persistent, still I cannot find out the way?","URL","1"]]
    var complaintId: Int = 0
    @IBOutlet weak var userComplaintInfoView: UIView!
    @IBOutlet weak var userComplaintUserNameLabel: UILabel!
    @IBOutlet weak var userComplaintSubjectLabel: UILabel!
    @IBOutlet weak var userComplaintComplaintImageView: UIImageView!
    @IBOutlet weak var userComplaintDescriptionLabel: UILabel!
    @IBOutlet weak var topConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var adminAddReactionView: UIView!
    @IBOutlet weak var adminReactionCOmmentTextFiedl: UITextField!
    @IBOutlet weak var adminReactionUploadImageBtn: UIButton!
    @IBOutlet weak var adminReactionSaveAdminReactionBtn: UIButton!
    
    @IBOutlet weak var adminResponseView: UIView!
    @IBOutlet weak var adminResponseCommentLabel: UILabel!
    @IBOutlet weak var adminResponseImageView: UIImageView!
    
    @IBOutlet weak var addCommentView: UIView!
    @IBOutlet weak var addCommentTitleLabel: UILabel!
    @IBOutlet weak var addCommentTextField: UITextField!
    @IBOutlet weak var addCommentUploadImageBtn: UIButton!
    @IBOutlet weak var addCommentSaveBtn: UIButton!
    
    @IBOutlet weak var complaintChatTableView: UITableView!
    @IBAction func adminCOmmentUploadImageAction(_ sender: UIButton) {
        
    }
    @IBAction func adminCommentSaveBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func furtherAddCommentUploadImageBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func furtherAddCommentSaveBtnAction(_ sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topConstraints.constant = 500
        UIView.animate(withDuration: 1.5, animations: {
            self.topConstraints.constant = 20
        })
        self.complaintChatTableView.estimatedRowHeight = 222
        self.complaintChatTableView.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
        self.complaintChatTableView.layer.cornerRadius = 10
        setView()
    }
    
    func setView(){
        userComplaintInfoView.layer.cornerRadius = 10
        adminAddReactionView.layer.cornerRadius = 10
        adminResponseView.layer.cornerRadius = 10
        addCommentView.layer.cornerRadius = 10
        adminReactionUploadImageBtn.layer.cornerRadius = 10
        adminReactionSaveAdminReactionBtn.layer.cornerRadius = 10
        addCommentUploadImageBtn.layer.cornerRadius = 10
        addCommentSaveBtn.layer.cornerRadius = 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return complaintsChatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if complaintsChatData.indices.contains(indexPath.row) {
            let tempChat = complaintsChatData[indexPath.row]
            //"0" means it is mine message
            //"1" means it is others message
            if tempChat[2] == "0"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "complaintsChatMyChatTableViewCell") as! complaintsChatMyChatTableViewCell
                cell.alpha = 0
                cell.complaintChatMyChatBackgroundView.layer.cornerRadius = 10
                cell.complaintChatMyChatCommentLabel.text = tempChat[0]
                cell.selectionStyle = .none
                UIView.animate(withDuration: 1) {
                    cell.alpha = 1.0
                }
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "complaintsChatOtherChatTableViewCell") as! complaintsChatOtherChatTableViewCell
                cell.alpha = 0
                cell.complaintChatMyChatBackgroundView.layer.cornerRadius = 10
                cell.complaintOtherChatCommentLabel.text = tempChat[0]
                cell.selectionStyle = .none
                UIView.animate(withDuration: 1) {
                    cell.alpha = 1.0
                }
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "complaintsChatOtherChatTableViewCell") as! complaintsChatOtherChatTableViewCell
            cell.alpha = 0
            return cell
        }
    }

}
