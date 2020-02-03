//
//  ComplaintDetailViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ComplaintDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    var complainDetailModel: ComplaintDetail?
    //0: For me, 1: For front one walas
    var complaintsChatData = [["The problem is persistent, still I cannot find out the way?","URL","0"], ["The problem is persistent, still I cannot find out the way?","URL","1"],["The problem is persistent, still I cannot find out the way?","URL","0"],["The problem is persistent, still I cannot find out the way?","URL","1"]]
    var complaintId: Int = 0
    @IBOutlet weak var userComplaintInfoView: UIView!
    @IBOutlet weak var userComplaintUserNameLabel: UILabel!
    @IBOutlet weak var userComplaintSubjectLabel: UILabel!
    @IBOutlet weak var userComplaintComplaintImageView: UIImageView!
    @IBOutlet weak var userComplaintDescriptionLabel: UILabel!
    @IBOutlet weak var topConstraints: NSLayoutConstraint!
    var username: String?
    var commentText: String?
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
    
    @IBOutlet weak var adminAddResponseHeightConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var adminResponseHeightConstraints: NSLayoutConstraint!
    
    
    @IBOutlet weak var userResponseViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var complaintChatTableView: UITableView!
    @IBAction func adminCOmmentUploadImageAction(_ sender: UIButton) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    @IBAction func adminCommentSaveBtnAction(_ sender: UIButton) {
        
        if self.adminReactionCOmmentTextFiedl.text == "" {
            showAlert("Please type comment first!")
            return
        }else if self.tempSelectedImage == nil{
            showAlert("Please attach image also!")
            return
        }
        
        self.showSpinner(onView: self.view)
        let params: Parameters = [
            "complaint_id": self.complaintId,
            "comment": "\(self.adminReactionCOmmentTextFiedl.text ?? "")"
        ]
        Alamofire.upload(multipartFormData:
            {
                (multipartFormData) in
                multipartFormData.append((self.tempSelectedImage ?? UIImage(named: "building")!).jpegData(compressionQuality: 0.1)!, withName: "image", fileName: "file_\(Int.random(in: 0 ... 10000)).jpeg", mimeType: "image/jpeg")
                for (key, value) in params
                {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
        }, to:URL(string: "\(ngRokUrl)adminFirstReaction") ?? "",headers:["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"])
        { (result) in
            switch result {
            case .success(let upload,_,_ ):
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                })
                upload.responseJSON
                    { response in
                        DispatchQueue.main.async {
                            self.removeSpinner()
                        }
                        //print response.result
                        if response.result.value != nil
                        {
                            let value = response.result.value
                            DispatchQueue.main.async {
                                self.showAlert("Responsed Successfully!!")
                                
                                //***********
                                //Reload the data again and set the screen with that data
                                
                            }
                        }else{
                            DispatchQueue.main.async {
                                self.showAlert("Some Error, Try again!")
                            }
                        }
                }
            case .failure(let encodingError):
                break
            }
        }
    }
    
    @IBAction func furtherAddCommentUploadImageBtnAction(_ sender: UIButton) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
    }
    var tempSelectedImage: UIImage?
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

        // Set photoImageView to display the selected image.
        self.tempSelectedImage = selectedImage
        self.addCommentUploadImageBtn.setTitle("\(selectedImage.accessibilityIdentifier ?? "Image Selected")", for: .normal)

        self.adminReactionUploadImageBtn.setTitle("\(selectedImage.accessibilityIdentifier ?? "Image Selected")", for: .normal)
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func furtherAddCommentSaveBtnAction(_ sender: UIButton) {
        
        if self.addCommentTextField.text == "" {
            showAlert("Please type comment first!")
            return
        }else if self.tempSelectedImage == nil{
            showAlert("Please attach image also!")
            return
        }
        
        self.showSpinner(onView: self.view)
        let params: Parameters = [
            "complaints_id": "\(self.complaintId)",
            "comment": "\(self.addCommentTextField.text ?? "")",
            "is_admin": "\(isAdminLoggedIn ? 1 : 0)"
        ]
        Alamofire.upload(multipartFormData:
            {
                (multipartFormData) in
                multipartFormData.append((self.tempSelectedImage ?? UIImage(named: "building")!).jpegData(compressionQuality: 0.1)!, withName: "image", fileName: "file_\(Int.random(in: 0 ... 10000)).jpeg", mimeType: "image/jpeg")
                for (key, value) in params
                {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
        }, to:URL(string: "\(ngRokUrl)further-comment") ?? "",headers:["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"])
        { (result) in
            switch result {
            case .success(let upload,_,_ ):
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                })
                upload.responseJSON
                    { response in
                        DispatchQueue.main.async {
                            self.removeSpinner()
                        }
                        //print response.result
                        if response.result.value != nil
                        {
                            let value = response.result.value
                            DispatchQueue.main.async {
                                self.showAlert("Responsed Successfully!!")
                                self.getComplaintDetailData()
                                //***********
                                //Reload the data again and set the screen with that data
                                
                            }
                        }else{
                            DispatchQueue.main.async {
                                self.showAlert("Some Error, Try again!")
                            }
                        }
                }
            case .failure(let encodingError):
                break
            }
        }
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
        self.userComplaintUserNameLabel.text = self.username ?? ""
        self.userComplaintSubjectLabel.text = self.commentText ?? ""
        self.adminResponseCommentLabel.text = "We will work on it"
//        self.adminAddReactionView.isHidden = true
//        self.adminAddResponseHeightConstraints.constant = 0
        getComplaintDetailData()
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
    
    func getComplaintDetailData(){
    //        showSpinner(onView: self.view)
        let headerValues = globalHeaderValue
        let request = getRequestUrlWithHeader(url: "complaintsdetail/\(complaintId)", method: "GET", header: headerValues , bodyParams: nil)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            self.removeSpinner()
            if (error != nil) {
                print(error ?? "")
            } else {
                let httpResponse = response as? HTTPURLResponse
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Body: \(String(describing: strData))")
                
                if(response != nil && data != nil){
                    switch  httpResponse?.statusCode {
                    case 200:
                        self.complainDetailModel = try? JSONDecoder().decode(ComplaintDetail.self,from: data!)
                            DispatchQueue.main.sync {
                                //
                                self.setDataValues()
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
        self.getComplaintDetailData()
       }))
       alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
       }))
       self.present(alert, animated: true, completion: nil)
   }
    
    func setDataValues(){
        let userComplaintSubject = self.complainDetailModel?.complaintsDetailData.subject ?? ""
        self.userComplaintSubjectLabel.text = "\(userComplaintSubject)"
        
        let imageURL = URL(string: "\(self.complainDetailModel?.imageRootUrl ?? "")/\(self.complainDetailModel?.complaintsDetailData.complaintUserImageUrl ?? "")")
        //            myImageView.contentMode = UIView.ContentMode.scaleToFill
        self.userComplaintComplaintImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named:"building"))
        
        var userComplaintDescription = self.complainDetailModel?.complaintsDetailData.complaintUserDescription ?? ""
        self.userComplaintDescriptionLabel.text = "\(userComplaintDescription)"
        
        //*******
        //Use userComplaintSubject and userComplaintDescription to calcuate height for userComplaintViewHeight
        let heightNeededForUserView = (300.0 - 36.0 + (userComplaintSubject.height(withConstrainedWidth: (self.userComplaintInfoView.frame.size.width - 28.0), font: UIFont.systemFont(ofSize: 15))) + (userComplaintDescription.height(withConstrainedWidth: (self.userComplaintInfoView.frame.size.width - 28.0), font: UIFont.systemFont(ofSize: 15))))
        
        self.userResponseViewHeightConstraint.constant = CGFloat(heightNeededForUserView)
        
        //Check if admin is loggedIn and if he has responded to this complaint
        if isAdminLoggedIn{
            if self.complainDetailModel?.complaintsDetailData.adminResolvedComment == "" || self.complainDetailModel?.complaintsDetailData.adminResolvedComment == nil{
//                self.adminResponseView.isHidden = false
//                self.adminResponseHeightConstraints.constant = 0
                self.adminResponseView.isHidden = true
                self.adminResponseHeightConstraints.constant = 0
            }else{
                self.adminAddReactionView.isHidden = true
                self.adminAddResponseHeightConstraints.constant = 0
                let adminResponse = self.complainDetailModel?.complaintsDetailData.adminResolvedComment ?? ""
                //*******
                //Calculat the total height required for the comment and based on those set the height for view
                let heightNeededForAdminView = (200.0 - 18.0 + (adminResponse.height(withConstrainedWidth: (self.userComplaintInfoView.frame.size.width - 28.0), font: UIFont.systemFont(ofSize: 15))))
                
                self.adminResponseHeightConstraints.constant = CGFloat(heightNeededForAdminView)
                
                
                self.adminResponseCommentLabel.text = "\(adminResponse)"
                let imageURL = URL(string: "\(self.complainDetailModel?.imageRootUrl ?? "")/\(self.complainDetailModel?.complaintsDetailData.adminImageUrl ?? "")")
                //            myImageView.contentMode = UIView.ContentMode.scaleToFill
                self.adminResponseImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named:"building"))
            }
        }else{
            //Hide Admin response View
            self.adminAddReactionView.isHidden = true
            self.adminAddResponseHeightConstraints.constant = 0
            //Check if Admin responded yet or not
            if self.complainDetailModel?.complaintsDetailData.adminResolvedComment == "" || self.complainDetailModel?.complaintsDetailData.adminResolvedComment == nil{
                self.adminResponseView.isHidden = true
                self.adminResponseHeightConstraints.constant = 0
            }else{
                let adminResponse = self.complainDetailModel?.complaintsDetailData.adminResolvedComment ?? ""
                //*******
                //Calculat the total height required for the comment and based on those set the height for view
                let heightNeededForAdminView = (200.0 - 21.0 + (adminResponse.height(withConstrainedWidth: (self.userComplaintInfoView.frame.size.width - 28.0), font: UIFont.systemFont(ofSize: 15))))
                
                self.adminResponseHeightConstraints.constant = CGFloat(heightNeededForAdminView)
                self.adminResponseCommentLabel.text = "\(adminResponse)"
                let imageURL = URL(string: "\(self.complainDetailModel?.imageRootUrl ?? "")/\(self.complainDetailModel?.complaintsDetailData.adminImageUrl ?? "")")
                //            myImageView.contentMode = UIView.ContentMode.scaleToFill
                self.adminResponseImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named:"building"))
            }
        }
        self.complaintChatTableView.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.complainDetailModel?.complaintsDetailData.furtherChatList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.complainDetailModel?.complaintsDetailData.furtherChatList.indices.contains(indexPath.row) ?? false {
            
            if let tempComplainChat = self.complainDetailModel?.complaintsDetailData.furtherChatList[indexPath.row]{
                if tempComplainChat.isAdmin == 1{
                    if isAdminLoggedIn{
                        let cell = tableView.dequeueReusableCell(withIdentifier: "complaintsChatMyChatTableViewCell") as! complaintsChatMyChatTableViewCell
                        cell.alpha = 0
                        cell.complaintChatMyChatBackgroundView.layer.cornerRadius = 10
                        cell.complaintChatMyChatCommentLabel.text = tempComplainChat.comment
                        print("\(self.complainDetailModel?.imageRootUrl ?? "")/\(tempComplainChat.image)")
                        let imageURL = URL(string: "\(self.complainDetailModel?.imageRootUrl ?? "")/\(tempComplainChat.image)")
                        //            myImageView.contentMode = UIView.ContentMode.scaleToFill
                        cell.complaintChatBUildingImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named:"building"))
                        cell.selectionStyle = .none
                        UIView.animate(withDuration: 1) {
                            cell.alpha = 1.0
                        }
                        return cell
                    }else{
                        let cell = tableView.dequeueReusableCell(withIdentifier: "complaintsChatOtherChatTableViewCell") as! complaintsChatOtherChatTableViewCell
                        cell.alpha = 0
                        cell.complaintChatMyChatBackgroundView.layer.cornerRadius = 10
                        cell.complaintOtherChatCommentLabel.text = tempComplainChat.comment
                        let imageURL = URL(string: "\(self.complainDetailModel?.imageRootUrl ?? "")/\(tempComplainChat.image)")
                        //            myImageView.contentMode = UIView.ContentMode.scaleToFill
                        cell.complaintsOtherChatImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named:"building"))
                        cell.selectionStyle = .none
                        UIView.animate(withDuration: 1) {
                            cell.alpha = 1.0
                        }
                        return cell
                    }
                }else{
                    if isAdminLoggedIn{
                        let cell = tableView.dequeueReusableCell(withIdentifier: "complaintsChatOtherChatTableViewCell") as! complaintsChatOtherChatTableViewCell
                        cell.alpha = 0
                        cell.complaintChatMyChatBackgroundView.layer.cornerRadius = 10
                        cell.complaintOtherChatCommentLabel.text = tempComplainChat.comment
                        let imageURL = URL(string: "\(self.complainDetailModel?.imageRootUrl ?? "")/\(tempComplainChat.image)")
                        //            myImageView.contentMode = UIView.ContentMode.scaleToFill
                        cell.complaintsOtherChatImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named:"building"))
                        cell.selectionStyle = .none
                        UIView.animate(withDuration: 1) {
                            cell.alpha = 1.0
                        }
                        return cell
                    }else{
                        let cell = tableView.dequeueReusableCell(withIdentifier: "complaintsChatMyChatTableViewCell") as! complaintsChatMyChatTableViewCell
                        cell.alpha = 0
                        cell.complaintChatMyChatBackgroundView.layer.cornerRadius = 10
                        cell.complaintChatMyChatCommentLabel.text = tempComplainChat.comment
                        let imageURL = URL(string: "\(self.complainDetailModel?.imageRootUrl ?? "")/\(tempComplainChat.image)")
                        //            myImageView.contentMode = UIView.ContentMode.scaleToFill
                        cell.complaintChatBUildingImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named:"building"))
                        cell.selectionStyle = .none
                        UIView.animate(withDuration: 1) {
                            cell.alpha = 1.0
                        }
                        return cell
                    }
                }
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "complaintsChatOtherChatTableViewCell") as! complaintsChatOtherChatTableViewCell
                cell.alpha = 0
                return cell
            }
            //"0" means it is mine message
            //"1" means it is others message
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "complaintsChatOtherChatTableViewCell") as! complaintsChatOtherChatTableViewCell
            cell.alpha = 0
            return cell
        }
    }

}
