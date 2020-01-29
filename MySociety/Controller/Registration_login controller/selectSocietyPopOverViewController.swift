//
//  selectSocietyPopOverViewController.swift
//  MySociety
//
//  Created by Admin on 24/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class selectSocietyPopOverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    let nc = NotificationCenter.default
    //SocietyName, SocietyRegistrationNumber, SocietyId
    var SocietyData: [[String]] = []
    var filteredTableData: [[String]] = []
    var resultSearchController = UISearchController()
    var societyListModel: societyList?
    @IBOutlet weak var popOverBackgroundView: UIView!
    @IBOutlet weak var societyListTableView: UITableView!
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
            societyListTableView.tableHeaderView = controller.searchBar

            return controller
        })()
        societyListTableView.reloadWithAnimation()
        self.resultSearchController.hidesNavigationBarDuringPresentation = false
        self.getSocietyListData()
    }
    
    func getSocietyListData(){
        showSpinner(onView: self.view)
        let headerValues = globalHeaderValue
        let request = getRequestUrlWithHeader(url: "society", method: "GET", header: headerValues , bodyParams: nil)
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
                        self.societyListModel = try? JSONDecoder().decode(societyList.self,from: data!)
                        if self.societyListModel?.societyData.count ?? 0 > 0{
                            for i in 0...(self.societyListModel?.societyData.count ?? 0) - 1{
                                if let tempSocietyData = self.societyListModel?.societyData[i]{
                                    self.SocietyData.append([tempSocietyData.societyName, tempSocietyData.SocietyRegistrationNumber, "\(tempSocietyData.societyId)"])
                                }
                            }
                        }
                            DispatchQueue.main.sync{
                                //Got the event data
                                self.societyListTableView.reloadData()
                                self.showToast(message: "Select the Society", fontSize: 11.0)
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
            self.getSocietyListData()
        }))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return SocietyData.count
        }
    }
    
    // Select item from tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (resultSearchController.isActive) {
            selectSocietySharedFile.shared.societySelectedName = filteredTableData[indexPath.row][0]
            selectSocietySharedFile.shared.societySelectedId = Int(filteredTableData[indexPath.row][2]) ?? 0
            nc.post(name: Notification.Name.selectSocietyPopOverDismissNC, object: nil)
            dismiss(animated: true, completion: nil)
            dismiss(animated: true, completion: nil)
        }else{
            selectSocietySharedFile.shared.societySelectedName = SocietyData[indexPath.row][0]
            selectSocietySharedFile.shared.societySelectedId = Int(SocietyData[indexPath.row][2]) ?? 0
            nc.post(name: Notification.Name.selectSocietyPopOverDismissNC, object: nil)
            dismiss(animated: true, completion: nil)
        }
    }
    
    //Assign values for tableView
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterUserSelctSocietyTableViewCell", for: indexPath) as! RegisterUserSelctSocietyTableViewCell
        cell.alpha = 0
        UIView.animate(withDuration: 1) {
            cell.alpha = 1.0
        }
        if (resultSearchController.isActive) {
            cell.societyNameLabel?.text = filteredTableData[indexPath.row][0]
            cell.societyRegistrationNumberLabel.text = "Registration: \(filteredTableData[indexPath.row][1])"
        }else{
            cell.societyNameLabel?.text = SocietyData[indexPath.row][0]
            cell.societyRegistrationNumberLabel.text = "Registration: \(SocietyData[indexPath.row][1])"
        }
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        filteredTableData = SocietyData.filter { (dataArray:[String]) -> Bool in
            return dataArray.filter({ (string) -> Bool in
                return string.lowercased().contains(searchController.searchBar.text!.lowercased())
            }).count > 0
        }
//        let searchPredicate = NSPredicate(format: "SELF[0] CONTAINS[c] %@", searchController.searchBar.text!)
//        let array = (SocietyData as NSArray).filtered(using: searchPredicate)
//        filteredTableData = array as! [[String]]
        self.societyListTableView.reloadWithAnimation()
    }

}
