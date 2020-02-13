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
    var memberDirectoryUserModel: memeberUsers?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memberDirectoryListTableView.layer.cornerRadius = 10
        self.makePositionChangeBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        if !isAdminLoggedIn{
            self.makePositionChangeBtn.isHidden = true
            
        }
    }
    
    var isFirstLoad: Bool = true
    override func viewWillAppear(_ animated: Bool) {
        self.getMemberUserData()
        self.isFirstLoad = false
    }
    
    func getMemberUserData(){
        if isFirstLoad{
            showSpinner(onView: self.view)
        }
        let headerValues = globalHeaderValue
        let request = getRequestUrlWithHeader(url: "member/\(loggedInUserId)", method: "GET", header: headerValues , bodyParams: nil)
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
                        self.memberDirectoryUserModel = try? JSONDecoder().decode(memeberUsers.self,from: data!)
                            DispatchQueue.main.sync {
                                self.memberDirectoryListTableView.reloadData()
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
            self.getMemberUserData()
           }))
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
           }))
           self.present(alert, animated: true, completion: nil)
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memberDirectoryUserModel?.memberDirectoryData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberDirectoryListTableViewCell") as! MemberDirectoryListTableViewCell
        cell.alpha = 0
        
        if self.memberDirectoryUserModel?.memberDirectoryData.indices.contains(indexPath.row) ?? false{
            let tempMemberDirectory = self.memberDirectoryUserModel?.memberDirectoryData[indexPath.row]
            cell.memberDIrectoryCellPositionLabel.text = tempMemberDirectory?.position ?? ""
            cell.memebrDirectoryMobileNumberlabel.text = "\(tempMemberDirectory?.contactnumber ?? "")"
            cell.memberDirectoryUserEmailIDLabel.text = tempMemberDirectory?.emailId ?? ""
            cell.memberDirectoryuserNameLabel.text = tempMemberDirectory?.name ?? ""
            cell.memberDirectoryPhoneBtn.addTarget(self, action: #selector(onCallClicked(sender:)), for: .touchUpInside)
            cell.memberDiretoryEMailBtn.addTarget(self, action: #selector(mailButtonAction(sender:)), for: .touchUpInside)
            cell.memberDirectoryWhatsappBtn.addTarget(self, action: #selector(whatsappButtonAction(sender:)), for: .touchUpInside)
            cell.memberDirectoryPhoneBtn.tag = indexPath.row
            cell.memberDiretoryEMailBtn.tag = indexPath.row
            cell.memberDirectoryWhatsappBtn.tag = indexPath.row
            cell.memberDirectoryBackgroundView.giveBorder()
        }
        cell.memberDirectoryBackgroundView.layer.cornerRadius = 10
        UIView.animate(withDuration: 1) {
            cell.alpha = 1.0
        }
        return cell
    }
    
    @objc func onCallClicked(sender: UIButton){
        let tag = sender.tag
        let contactNumber = "\(self.memberDirectoryUserModel?.memberDirectoryData[tag].contactnumber ?? "")"
        guard let number = URL(string: "tel://" + "\(contactNumber)") else { return }
        UIApplication.shared.open(number)
    }
    
    @objc func mailButtonAction(sender: UIButton) {
        let email = "\(self.memberDirectoryUserModel?.memberDirectoryData[sender.tag].emailId ?? "")"
        if let url = URL(string: "mailto:\(email)") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
    
    @objc func whatsappButtonAction(sender: UIButton) {
        let urlWhats = "whatsapp://send?phone=+91\(self.memberDirectoryUserModel?.memberDirectoryData[sender.tag].contactnumber ?? "")"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install Whatsapp")
                }
            }
        }
    }

}
