//
//  PayManintenanceMAountViewController.swift
//  MySociety
//
//  Created by Admin on 15/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Alamofire
class PayManintenanceMAountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var tempSelectedImage: UIImage?
    let nc = NotificationCenter.default
    var selectedMemberId: Int = 0
    var selectedMemberName: String = ""
    @IBOutlet weak var flatNumberTextField: UITextField!
    @IBOutlet weak var wingTextField: UITextField!
    
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var seleectMemberButton: UIButton!
    @IBOutlet weak var billAmountTextField: UITextField!
    
    @IBOutlet weak var balancedAmountLABL: UILabel!
    @IBOutlet weak var balancedAmountTextLabel: UILabel!
    
    @IBOutlet weak var seledctMonthYAerTitleLbel: UILabel!
    @IBOutlet weak var selectMonthYearDatePicker: UIDatePicker!
    
    @IBOutlet weak var amountPayingTitle: UILabel!
    @IBOutlet weak var amountPayingTextField: UITextField!
    
    @IBOutlet weak var transcationIdTitleLabel: UILabel!
    
    @IBOutlet weak var transtionIdTextField: UITextField!
    
    @IBOutlet weak var uploadImageBtn: UIButton!
    
    @IBAction func uploadImageAction(_ sender: UIButton) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
    }
    @IBOutlet weak var saveBtn: UIButton!
    @IBAction func saveBtnAction(_ sender: UIButton) {
        self.postMaintenanceData()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

        // Set photoImageView to display the selected image.
        self.tempSelectedImage = selectedImage

        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seleectMemberButton.layer.cornerRadius = 10
        uploadImageBtn.layer.cornerRadius = 10
        saveBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        nc.addObserver(self, selector: #selector(updateSelectedMemberLabels), name: Notification.Name.selectUserMemberForMaintenancePopOverDismissNC, object: nil)
    }
    
    func postMaintenanceData(){
        self.showSpinner(onView: self.view)
//        let parameters = [
//            "wing": self.wingTextField.text ?? "",
//            "flat_No": self.flatNumberTextField.text ?? "",
//            "monthAndYearOfBill": "\(getDateInDateFormate(date: self.selectMonthYearDatePicker.date))",
//            "amount_paying": self.amountPayingTextField.text ?? "",
//            "transaction_id": self.transtionIdTextField.text ?? "",
//            "transaction_image": "https://scx2.b-cdn.net/gfx/news/hires/2019/2-nature.jpg",
//            "selected_user_id": self.selectedMemberId,
//            "bill_amount": self.billAmountTextField.text ?? ""
//            ] as [String : Any]
//        let headerValues = ["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"]
//        let request = getRequestUrlWithHeader(url: "addmaintenance/\(loggedInUserId)", method: "POST", header: headerValues, bodyParams: parameters)
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            DispatchQueue.main.async {
//                self.removeSpinner()
//            }
//            if (error != nil) {
//                print(error ?? "")
//            } else {
//                let httpResponse = response as? HTTPURLResponse
//
//                switch(httpResponse?.statusCode ?? 201){
//                case 200, 201:
//                    DispatchQueue.main.async {
//                        self.showAlertForError("Maintenance Paid Successfully!!")
//                    }
//                default:
//                    DispatchQueue.main.async {
//                        self.showAlertForError("Some Error has occured, try again!")
//                    }
//                }
//            }
//        })
//        dataTask.resume()
        
        
        
        
        let params: Parameters = [
            "wing": self.wingTextField.text ?? "",
            "flat_No": self.flatNumberTextField.text ?? "",
            "monthAndYearOfBill": "\(getDateInDateFormate(date: self.selectMonthYearDatePicker.date))",
            "amount_paying": self.amountPayingTextField.text ?? "",
            "transaction_id": self.transtionIdTextField.text ?? "",
            "selected_user_id": self.selectedMemberId,
            "bill_amount": self.billAmountTextField.text ?? ""
        ]
        Alamofire.upload(multipartFormData:
            {
                (multipartFormData) in
                multipartFormData.append((self.tempSelectedImage ?? UIImage(named: "building")!).jpegData(compressionQuality: 0.1)!, withName: "image", fileName: "file_\(Int.random(in: 0 ... 10000)).jpeg", mimeType: "image/jpeg")
                for (key, value) in params
                {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
        }, to:URL(string: "\(ngRokUrl)addmaintenance/\(loggedInUserId)") ?? "",headers:["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"])
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
                                self.showAlert("Notice created Successfully!!")
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
    
    func showAlert(_ message: String) -> (){
        let alert = UIAlertController(title: message, message: nil , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getDateInDateFormate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
    
    func showAlertForError(_ message: String) -> (){
        let alert = UIAlertController(title: message, message: nil , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func updateSelectedMemberLabels(){
        self.seleectMemberButton.setTitle("\(payMaintenanceSelectMemberSharedFile.shared.memberSelectedName)", for: .normal)
        self.selectedMemberId = payMaintenanceSelectMemberSharedFile.shared.memberSelectedId
        self.balancedAmountTextLabel.text = "\(payMaintenanceSelectMemberSharedFile.shared.memberSelectedBalanceAmount)"
    }
   
    func myImageUploadRequest()
        {
            let myUrl = NSURL(string: "http://www.swiftdeveloperblog.com/http-post-example-script/");
            //let myUrl = NSURL(string: "http://www.boredwear.com/utils/postImage.php");
            
            let request = NSMutableURLRequest(url:myUrl! as URL);
            request.httpMethod = "POST";
            
            let param = [
                "firstName"  : "Sergey",
                "lastName"    : "Kargopolov",
                "userId"    : "9"
            ]
            
            let boundary = generateBoundaryString()
            
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
     
            let imageData = (self.tempSelectedImage ?? UIImage(named: "building")!).jpegData(compressionQuality: 1)
            
            if(imageData==nil)  { return; }
            
            request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data
            
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                if error != nil {
//                    print("error=\(error)")
                    return
                }
                
                // You can print out response object
//                print("******* response = \(response)")
                
                // Print out reponse body
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("****** response data = \(responseString!)")
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    
//                    print(json)
                    
//                    dispatch_async(dispatch_get_main_queue(),{
//                        self.myActivityIndicator.stopAnimating()
//                        self.myImageView.image = nil;
//                    });
//
                    DispatchQueue.global(qos: .background).async {

                        // Background Thread

                        DispatchQueue.main.async {
                            self.uploadImageBtn.setTitle("Select Image", for: .normal)
                        }
                    }
                    
                }catch
                {
                    print(error)
                }
                
            }
            
            task.resume()
        }
        
        
        func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
            let body = NSMutableData();
            
            if parameters != nil {
                for (key, value) in parameters! {
                    body.appendString(string: "--\(boundary)\r\n")
                    body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                    body.appendString(string: "\(value)\r\n")
                }
            }
           
                    let filename = "user-profile.jpg"
                    let mimetype = "image/jpg"
                    
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
            body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
            body.append(imageDataKey as Data)
            body.appendString(string: "\r\n")
            
        
            
            body.appendString(string: "--\(boundary)--\r\n")
            
            return body
        }
        
        
        
        func generateBoundaryString() -> String {
            return "Boundary-\(NSUUID().uuidString)"
        }
     
     
    }
    extension NSMutableData {
       
        func appendString(string: String) {
            let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
            append(data!)
        }
    }
