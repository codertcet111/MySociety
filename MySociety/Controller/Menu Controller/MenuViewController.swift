//
//  MenuViewController.swift
//  MySociety
//
//  Created by Admin on 10/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class MenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource{

    var adminMenuOptions: [[String]] = [["Notice & Circular","Notice_Circulate"], ["Event","EventLogo"], ["Complaints", "complaint"], ["Maintenance", "maintenance"], ["Member Directory", "memberDirectory"], ["Opinion Poll", "poll"], ["Election", "ElectionIcon"], ["Group Chat","GroupChat"], ["FeedBack","feedback"], ["Manual Video","video-players"]]
    var userMenuOptions: [[String]] = []
    @IBOutlet weak var menuCollectionViewOutlet: UICollectionView!
    @IBOutlet weak var collectionTopConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var notificationMenuTableView: UITableView!
    
    @IBOutlet weak var readMoreBtn: UIButton!
    @IBAction func readMoreAction(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var collectionHeightConstraints: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let layout = AnimatedCollectionViewLayout()
//        layout.animator = LinearCardAttributesAnimator()
//        menuCollectionViewOutlet.collectionViewLayout = layout
//        menuCollectionViewOutlet.reloadData()
        collectionTopConstraints.constant = 400
        collectionTopConstraints.constant = 40
        collectionHeightConstraints.constant = 50.0
        collectionHeightConstraints.constant = 200
        notificationMenuTableView.alpha = 0
        notificationMenuTableView.alpha = 1
        readMoreBtn.layer.cornerRadius = 10
        readMoreBtn.alpha = 0
        readMoreBtn.alpha = 1
        UIView.animate(withDuration: 1.5, animations: {
            self.view.layoutIfNeeded()
        })
        self.notificationMenuTableView.estimatedRowHeight = 59
        self.notificationMenuTableView.rowHeight = UITableView.automaticDimension
        self.setUpNavigationButtons()
        
    }
    
    func setUpNavigationButtons(){
        
        let notificationItemBtn = UIButton(type: .custom)
        notificationItemBtn.setImage(UIImage(named: "christmas-bell"), for: .normal)
        notificationItemBtn.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        if notificationBadgedCount > 0{
            notificationItemBtn.addSubview(getBadgedLabelWithValue(count: notificationBadgedCount))
        }
        notificationItemBtn.addTarget(self, action: #selector(NotificationNavigationButtonClicked), for: .touchUpInside)
        let notificationItem = UIBarButtonItem(customView: notificationItemBtn)
        
        
        let logOutItemBtn = UIButton(type: .custom)
        logOutItemBtn.setImage(UIImage(named: "exit-2"), for: .normal)
        logOutItemBtn.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        logOutItemBtn.addTarget(self, action: #selector(logOutNavigationButtonClicked), for: .touchUpInside)
        let notificationItem1 = UIBarButtonItem(customView: logOutItemBtn)
        
        
    self.navigationItem.setRightBarButtonItems([notificationItem1, notificationItem], animated: true)
    }
    
    @objc func NotificationNavigationButtonClicked(){
        notificationBadgedCount = 0
        //Now, Task 1: Notify to all VC to remove badge, Task 2: Remove badge in this VC also
        //WARNING: For the timming I have implemented by calling 'setUpNavigationButtons' again, in future just removeSubView only from the clicked bar item
//        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "notificationViewController") as? notificationViewController
//        self.navigationController?.pushViewController(vc2!, animated: true)
        
        self.performSegue(withIdentifier: "notificationFromMenuSegue", sender: self)
    }
    
    @objc func logOutNavigationButtonClicked(){
        //Delete default user data, then redirect to registration Options screen
//        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "registrationOptionsViewController") as? registrationOptionsViewController
//        self.navigationController?.pushViewController(vc2!, animated: true)
        UserDefaults.standard.set(0, forKey: loggedInUserIdDefaultKeyName)
        UserDefaults.standard.set(false, forKey: loggedInUserIsAdminDefaultKeyName)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = storyboard.instantiateViewController(withIdentifier: "registrationOptionsViewController") as! registrationOptionsViewController
        let nav = UINavigationController(rootViewController: vc)
       appDelegate.window!.rootViewController = nav
        self.performSegue(withIdentifier: "loggedOutSegue", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adminMenuOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuViewCollectionViewCell", for: indexPath) as! menuViewCollectionViewCell
        let tempData = adminMenuOptions[indexPath.row]
        cell.cellImageView.image = UIImage(named: "\(tempData[1])")
        cell.cellMenuLabelOutlet.text = tempData[0]
//        cell.cellBackgroundView.layer.cornerRadius = 10.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch(indexPath.row){
        case 0:
            self.performSegue(withIdentifier: "noticeListSegue", sender: self)
        case 1:
            self.performSegue(withIdentifier: "eventListMenuSegue", sender: self)
        case 2:
            self.performSegue(withIdentifier: "complaintListFromMenuSegue", sender: self)
        case 3:
            self.performSegue(withIdentifier: "maintenanceListFromMenuSegue", sender: self)
        case 4:
            self.performSegue(withIdentifier: "MemberDirectoryFromMenuSegue", sender: self)
        case 5:
            self.performSegue(withIdentifier: "OpenOpinionPollListViewSegue", sender: self)
        case 6:
            self.performSegue(withIdentifier: "electionListFromMenuSegue", sender: self)
        case 7:
            self.performSegue(withIdentifier: "GroupChatOpenSegue", sender: self)
        case 8:
            self.performSegue(withIdentifier: "FeedbackOpenSegue", sender: self)
        case 9:
            self.performSegue(withIdentifier: "uploadVideoSegue", sender: self)
        default:
            self.performSegue(withIdentifier: "noticeListSegue", sender: self)
        }
    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSize(width: 263.0, height: 170.0)
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationInMenuTableViewCell") as! NotificationInMenuTableViewCell
        cell.alpha = 0
        
        cell.notificationMenuBackgroundView.layer.cornerRadius = 10.0
        cell.selectionStyle = .none
        UIView.animate(withDuration: 1) {
            cell.alpha = 1.0
        }
        return cell
    }
    

}
