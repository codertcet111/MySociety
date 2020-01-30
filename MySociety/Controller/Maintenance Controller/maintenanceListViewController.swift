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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.maintenanceTableView.estimatedRowHeight = 164
        self.maintenanceTableView.rowHeight = UITableView.automaticDimension
        payMaintenanceBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        self.getMaintenanceData()
    }
    
    func getMaintenanceData(){
        showSpinner(onView: self.view)
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
            self.getMaintenanceData()
           }))
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
           }))
           self.present(alert, animated: true, completion: nil)
       }

    @objc func changeStateButtonAction(sender:UIButton)
    {
        
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
            cell.statusBtn.addTarget(self, action: #selector(changeStateButtonAction(sender:)), for: .touchUpInside)
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
