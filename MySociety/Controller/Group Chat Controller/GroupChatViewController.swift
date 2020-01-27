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
        self.postChat()
        self.typeMessageTextField.text = ""
    }
    @IBOutlet weak var typeMessageTextField: UITextField!
    @IBOutlet weak var groupChatMessageTypeView: UIView!
    
    var chatModel: chat?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.groupChatTableView.estimatedRowHeight = 164
        self.groupChatTableView.rowHeight = UITableView.automaticDimension
        
        getChatData(true)
    }
    
    @IBAction func textField(_ sender: AnyObject) {
        self.view.endEditing(true);
    }
    
    func postChat(){
        self.showSpinner(onView: self.view)
        let parameters = [
            "text": "\(self.typeMessageTextField.text ?? "")",
            "userId": "\(loggedInUserId)"
            ] as [String : Any]
        let headerValues = ["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"]
        let request = getRequestUrlWithHeader(url: "addchat/\(loggedInUserId)", method: "POST", header: headerValues, bodyParams: parameters)
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
//                        self.showAlertForError("Chat Posted Successfully!!")
                        self.getChatData(false)
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
    
    
    func getChatData(_ showSpinnerView: Bool){
        if showSpinnerView{
            showSpinner(onView: self.view)
        }
        let headerValues = globalHeaderValue
        let request = getRequestUrlWithHeader(url: "chat/\(loggedInUserId)", method: "GET", header: headerValues , bodyParams: nil)
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
                        self.chatModel = try? JSONDecoder().decode(chat.self,from: data!)
                            DispatchQueue.main.sync {
                                self.groupChatTableView.reloadData()
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
            self.getChatData(true)
           }))
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
           }))
           self.present(alert, animated: true, completion: nil)
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatModel?.chatData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.chatModel?.chatData.indices.contains(indexPath.row) ?? false{
            let tempchat = self.chatModel?.chatData[indexPath.row]
            if tempchat?.userId ?? 0 == loggedInUserId{
                let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCHatMyCHatTableViewCell") as! GroupCHatMyCHatTableViewCell
                cell.alpha = 0
                cell.myChatBackgroundView.layer.cornerRadius = 10
                cell.myChatMyMessageLabel.text = tempchat?.text ?? ""
                cell.myChatTimeStampLabel.text = tempchat?.datetime ?? ""
                
                cell.selectionStyle = .none
                UIView.animate(withDuration: 1) {
                    cell.alpha = 1.0
                }
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "groupChatOthersCHatTableViewCell") as! groupChatOthersCHatTableViewCell
                cell.alpha = 0
                cell.otherChatBackgroundView.layer.cornerRadius = 10
                cell.otherChatUserNameLabel.text = tempchat?.userName ?? ""
                cell.otherCHatMEssageLabel.text = tempchat?.text ?? ""
                cell.otherChatDatetimeLabel.text = tempchat?.datetime ?? ""
                cell.selectionStyle = .none
                UIView.animate(withDuration: 1) {
                    cell.alpha = 1.0
                }
                return cell
            }
        }else{
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
