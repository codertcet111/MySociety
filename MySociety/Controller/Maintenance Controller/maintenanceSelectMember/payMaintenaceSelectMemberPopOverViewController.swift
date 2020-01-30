//
//  payMaintenaceSelectMemberPopOverViewController.swift
//  MySociety
//
//  Created by Admin on 26/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class payMaintenaceSelectMemberPopOverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    let nc = NotificationCenter.default
    var userData: [[String]] = []
    
    var filteredTableData: [[String]] = []
    var resultSearchController = UISearchController()
    var userListModel: UsersList?
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
        self.getUserListData()
    }
    
     func getUserListData(){
            showSpinner(onView: self.view)
            let headerValues = globalHeaderValue
            let request = getRequestUrlWithHeader(url: "users/2", method: "GET", header: headerValues , bodyParams: nil)
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
                            self.userListModel = try? JSONDecoder().decode(UsersList.self,from: data!)
                            if self.userListModel?.tempusersData.count ?? 0 > 0{
                                for i in 0...(self.userListModel?.tempusersData.count ?? 0) - 1{
                                    if let tempData = self.userListModel?.tempusersData[i]{
                                        self.userData.append([tempData.fullName, tempData.mobile, "\(tempData.id)"])
                                    }
                                }
                            }
                            DispatchQueue.main.sync{
                                //Got the event data
                                self.memberListTableView.reloadData()
                                self.showToast(message: "Select the Member", fontSize: 11.0)
//                                self.getSocietyListData()
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
                self.getUserListData()
            }))
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return userData.count
        }
    }
    
    // Select item from tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (resultSearchController.isActive) {
            payMaintenanceSelectMemberSharedFile.shared.memberSelectedName = filteredTableData[indexPath.row][0]
            payMaintenanceSelectMemberSharedFile.shared.memberSelectedId = Int(filteredTableData[indexPath.row][2]) ?? 0
            nc.post(name: Notification.Name.selectUserMemberForMaintenancePopOverDismissNC, object: nil)
            dismiss(animated: true, completion: nil)
            dismiss(animated: true, completion: nil)
        }else{
            payMaintenanceSelectMemberSharedFile.shared.memberSelectedName = userData[indexPath.row][0]
            payMaintenanceSelectMemberSharedFile.shared.memberSelectedId = Int(userData[indexPath.row][2]) ?? 0
            nc.post(name: Notification.Name.selectUserMemberForMaintenancePopOverDismissNC, object: nil)
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
            cell.memberNameLabel?.text = filteredTableData[indexPath.row][0]
            cell.memberPhoneNumberLabel.text = "Mobile: \(filteredTableData[indexPath.row][1])"
        }else{
            cell.memberNameLabel?.text = userData[indexPath.row][0]
            cell.memberPhoneNumberLabel.text = "Mobile: \(userData[indexPath.row][1])"
        }
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        filteredTableData = userData.filter { (dataArray:[String]) -> Bool in
            return dataArray.filter({ (string) -> Bool in
                return string.lowercased().contains(searchController.searchBar.text!.lowercased())
            }).count > 0
        }
        self.memberListTableView.reloadWithAnimation()
    }

}
