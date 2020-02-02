//
//  maintenanceListViewController.swift
//  MySociety
//
//  Created by Admin on 15/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class maintenanceListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var maintenanceTableView: UITableView!
    
    @IBOutlet weak var payMaintenanceBtn: UIButton!
    var maintenanceListModel: maintenanceList?
    @IBAction func payMaintenanceBtnAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "payMaintenanceSegue", sender: self)
    }
    var maintenanceStates: [String] = ["Approved","Reject"]
    var changemaintennaceID: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.maintenanceTableView.estimatedRowHeight = 164
        self.maintenanceTableView.rowHeight = UITableView.automaticDimension
        payMaintenanceBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        if !isAdminLoggedIn{
            self.payMaintenanceBtn.isHidden = true
            
        }
        self.getMaintenanceData(true)
    }
    
    func getMaintenanceData(_ showSpinnerView: Bool){
        if showSpinnerView{
            showSpinner(onView: self.view)
        }
        let headerValues = globalHeaderValue
        let request = getRequestUrlWithHeader(url: "maintenance/\(loggedInUserId)", method: "GET", header: headerValues , bodyParams: nil)
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
                        self.maintenanceListModel = try? JSONDecoder().decode(maintenanceList.self,from: data!)
                            DispatchQueue.main.sync {
                                self.maintenanceTableView.reloadData()
                                self.removeSpinner()
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
    
    func showAlert(_ message: String) -> (){
           let alert = UIAlertController(title: message, message: nil , preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: { _ in
            self.getMaintenanceData(true)
           }))
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
           }))
           self.present(alert, animated: true, completion: nil)
       }

    @objc func changeStateButtonAction(sender:UIButton)
    {
        let alert = UIAlertController(title: "Change Payment State", message: nil, preferredStyle: .alert)
        
        let closure = { (action: UIAlertAction!) -> Void in
            if action.title?.lowercased() == self.maintenanceListModel?.maintenanceData[sender.tag].status?.lowercased() ?? ""{
                //DO nothing
            }else{
                //change the maintenance state
                self.changemaintennaceID = self.maintenanceListModel?.maintenanceData[sender.tag].id ?? 0
                self.changeMaintenanceState("\(action.title?.lowercased() ?? "approved")")
            }
        }
        for tempRole in maintenanceStates {
            alert.addAction(UIAlertAction(title: tempRole, style: .default, handler: closure))
        }
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: {(_) in }))
        self.present(alert, animated: false, completion: nil)
    }
    
    func changeMaintenanceState(_ newState: String){
        self.showSpinner(onView: self.view)
        let parameters = [
            "maintenance_id": self.changemaintennaceID,
            "newStatus": "\(newState)"
            ] as [String : Any]
        let headerValues = ["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"]
        let request = getRequestUrlWithHeader(url: "maintenance-change-status", method: "POST", header: headerValues, bodyParams: parameters)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.removeSpinner()
            }
            if (error != nil) {
                print(error ?? "")
            } else {
                let httpResponse = response as? HTTPURLResponse
                
                switch(httpResponse?.statusCode ?? 201){
                case 200, 201:
                    DispatchQueue.main.async {
                        self.showAlertForError("Status updated Successfully!!")
                        self.getMaintenanceData(false)
                    }
                default:
                    DispatchQueue.main.async {
                        self.showAlertForError("Some Error has occured, try again!")
                    }
                }
            }
        })
        
        dataTask.resume()
    }
        
    func showAlertForError(_ message: String) -> (){
        let alert = UIAlertController(title: message, message: nil , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.maintenanceListModel?.maintenanceData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.maintenanceListModel?.maintenanceData.indices.contains(indexPath.row) ?? false{
            let tempMaintenaceData = self.maintenanceListModel?.maintenanceData[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "maintenanceTableViewCell") as! maintenanceTableViewCell
            cell.alpha = 0
            cell.maintenanceBackgroundView.layer.cornerRadius = 10
            cell.statusBtn.layer.cornerRadius = 10
            cell.selectionStyle = .none
            cell.FlatNumberLabel.text = "Flat: \(tempMaintenaceData?.FlatNo ?? "")/ \(tempMaintenaceData?.wing ?? "")"
            cell.billDateLabel.text = "Bill Date: \(tempMaintenaceData?.Billdate ?? "")"
            cell.paidDateLabel.text = "Paid On: \(tempMaintenaceData?.Paiddate ?? "")"
            cell.paidAmountLabel.text = "Amount Paid: \(tempMaintenaceData?.paidAmount ?? 0)"
            cell.statusBtn.setTitle("\(tempMaintenaceData?.status ?? "")", for: .normal)
            if isAdminLoggedIn{
                cell.statusBtn.addTarget(self, action: #selector(changeStateButtonAction(sender:)), for: .touchUpInside)
                cell.statusBtn.tag = indexPath.row
            }
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "maintenanceTableViewCell") as! maintenanceTableViewCell
            cell.alpha = 0
            cell.maintenanceBackgroundView.layer.cornerRadius = 10
            cell.statusBtn.layer.cornerRadius = 10
            cell.selectionStyle = .none
            UIView.animate(withDuration: 1) {
                cell.alpha = 1.0
            }
            return cell
        }
    }

}
