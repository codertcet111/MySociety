//
//  selectMemberPopOverViewController.swift
//  MySociety
//
//  Created by Admin on 26/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class selectMemberPopOverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    let nc = NotificationCenter.default
    var names: [String] = ["Mumbai","New York","Tokyo","London","Beijing","Sydney","Wellington","Madrid","Rome","Cape Town","Ottawa"]
    
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
    @IBOutlet weak var popOverBackgroundView: UIView!
    @IBOutlet weak var memberListTableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.layer.cornerRadius = 10
        popOverBackgroundView.layer.cornerRadius = 10
        popOverBackgroundView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.backgroundColor = UIColor.clear
            memberListTableView.tableHeaderView = controller.searchBar

            return controller
        })()
        memberListTableView.reloadWithAnimation()
        self.resultSearchController.hidesNavigationBarDuringPresentation = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return names.count
        }
    }
    
    // Select item from tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (resultSearchController.isActive) {
            selectMemberSharedFile.shared.memberSelectedName = filteredTableData[indexPath.row]
            selectMemberSharedFile.shared.memberSelectedId = indexPath.row
            nc.post(name: Notification.Name.selectUserMemberPopOverDismissNC, object: nil)
            dismiss(animated: true, completion: nil)
            dismiss(animated: true, completion: nil)
        }else{
            selectMemberSharedFile.shared.memberSelectedName = names[indexPath.row]
            selectMemberSharedFile.shared.memberSelectedId = indexPath.row
            nc.post(name: Notification.Name.selectUserMemberPopOverDismissNC, object: nil)
            dismiss(animated: true, completion: nil)
        }
    }
    
    //Assign values for tableView
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectMemberTableViewCell", for: indexPath) as! selectMemberTableViewCell
        cell.alpha = 0
        UIView.animate(withDuration: 1) {
            cell.alpha = 1.0
        }
        if (resultSearchController.isActive) {
            cell.memberNameLabel?.text = filteredTableData[indexPath.row]
            cell.memberPhoneNumberLabel.text = "1111"
        }else{
            cell.memberNameLabel?.text = names[indexPath.row]
            cell.memberPhoneNumberLabel.text = "1111"
        }
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (names as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]
        self.memberListTableView.reloadWithAnimation()
    }

}
