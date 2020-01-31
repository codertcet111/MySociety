//
//  NewNoticeViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Alamofire

class NewNoticeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var newNoticeSetTitleTextField: UITextField!
    @IBOutlet weak var selectTimeLAbel: UILabel!
    @IBOutlet weak var newNoticeSelectImageBtn: UIButton!
    
    @IBOutlet weak var newNoticeSaveBtn: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var NewNoticeDatePicker: UIDatePicker!
    @IBOutlet weak var setTitleTextTopConstraints: NSLayoutConstraint!
    
    @IBAction func selectImageAction(_ sender: UIButton) {
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
        self.newNoticeSelectImageBtn.setTitle("\(selectedImage.accessibilityIdentifier ?? "😄 Selected")", for: .normal)

        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveNoticeAction(_ sender: UIButton) {
        self.createNotice()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }
    
    
    func setView(){
        newNoticeSaveBtn.layer.cornerRadius = 10
        newNoticeSelectImageBtn.layer.cornerRadius = 10
        setTitleTextTopConstraints.constant = 500
        setTitleTextTopConstraints.constant = 45
        
        newNoticeSetTitleTextField.alpha = 0
        selectTimeLAbel.alpha = 0
        newNoticeSelectImageBtn.alpha = 0
        newNoticeSaveBtn.alpha = 0
        descriptionTextField.alpha = 0
        NewNoticeDatePicker.alpha = 0
        
        newNoticeSetTitleTextField.alpha = 1
        selectTimeLAbel.alpha = 1
        newNoticeSelectImageBtn.alpha = 1
        newNoticeSaveBtn.alpha = 1
        descriptionTextField.alpha = 1
        NewNoticeDatePicker.alpha = 1
        
        UIView.animate(withDuration: 1.5, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
    func createNotice(){
        self.showSpinner(onView: self.view)
        
//         let image = (self.tempSelectedImage ?? UIImage(named: "building")!)
//        let imgData = image.jpegData(compressionQuality: 0.2)!
//
//         let parameters = [
//            "userId": "\(loggedInUserId)",
//            "title": "\(self.newNoticeSetTitleTextField.text ?? "")",
//            "date": "\(self.getDateInDateFormate(date: Date()))",
//            "description": "\(self.descriptionTextField.text ?? "")",
//            "receiverId": ""
//        ] //Optional for extra parameter
//
//        Alamofire.upload(multipartFormData: { multipartFormData in
//                multipartFormData.append(imgData, withName: "image",fileName: "file.jpg", mimeType: "image/jpg")
//                for (key, value) in parameters {
//                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//                    } //Optional for extra parameters
//            },
//        to:"\(ngRokUrl)addnotice/\(loggedInUserId)", headers: ["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"])
//        { (result) in
//            DispatchQueue.main.async {
//                self.removeSpinner()
//            }
//            switch result {
//            case .success(let upload, _, _):
//
//                upload.uploadProgress(closure: { (progress) in
//                    print("Upload Progress: \(progress.fractionCompleted)")
//                    DispatchQueue.main.async {
//                        self.showAlert("Notice created Successfully!!")
//                    }
//                })
//
//                upload.responseJSON { response in
//                    print(response.result.value ?? "")
//                }
//
//            case .failure(let encodingError):
//                print(encodingError)
//            }
//        }
        
        
        
        
        
        
        
//        let param = [
//            "userId": "\(loggedInUserId)",
//            "title": "\(self.newNoticeSetTitleTextField.text ?? "")",
//            "date": "\(self.getDateInDateFormate(date: Date()))",
//            "description": "\(self.descriptionTextField.text ?? "")",
//            "receiverId": ""
//            ] as [String : Any]
//        let headerValues = ["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"]
//        let request = getRequestUrlWithHeader(url: "addnotice/\(loggedInUserId)", method: "POST", header: headerValues, bodyParams: param)
//
//        let boundary = generateBoundaryString()
//       request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//       let imageData = (self.tempSelectedImage ?? UIImage(named: "building")!).jpegData(compressionQuality: 1)
//       if(imageData==nil)  { return; }
//        request.httpBody = createBodyWithParameters(parameters: param as? [String : String], filePathKey: "image", imageDataKey: imageData! as NSData, boundary: boundary) as Data
//
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
//                        self.showAlert("Notice created Successfully!!")
//                    }
//                default:
//                    DispatchQueue.main.async {
//                        self.showAlert("Some Error has occured, try again!")
//                    }
//                }
//            }
//        })
//
//        dataTask.resume()
        
        
        
        
        
        
        
//        let url = URL(string: "\(ngRokUrl)addnotice/\(loggedInUserId)")
//
//        // generate boundary string using a unique per-app string
//        let boundary = UUID().uuidString
//
//        let session = URLSession.shared
//
//        // Set the URLRequest to POST and to the specified URL
//        var urlRequest = URLRequest(url: url!)
//        urlRequest.httpMethod = "POST"
////        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        urlRequest.setValue("1c552e6f2a95a883209e9b449d6f4973", forHTTPHeaderField: "x-api-key")
//
//        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
//        // And the boundary is also set here
//        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//        var data = Data()
//
//        let image = (self.tempSelectedImage ?? UIImage(named: "building")!)
//        // Add the image data to the raw http request data
//        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//        data.append("Content-Disposition: form-data; name=\"image\"; filename=\"notice_image\"\r\n".data(using: .utf8)!)
//        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
//        data.append(image.pngData()!)
//
//        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//
//        // Send a POST request to the URL, with the data we created earlier
//        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
//            DispatchQueue.main.async {
//                self.removeSpinner()
//            }
//            if error == nil {
//                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
//                if let json = jsonData as? [String: Any] {
//                    print(json)
//                    DispatchQueue.main.async {
//                        self.showAlert("Notice created Successfully!!")
//                    }
//                }
//            }
//        }).resume()
        
        
        
        let params: Parameters = [
            "userId": "\(loggedInUserId)",
            "title": "\(self.newNoticeSetTitleTextField.text ?? "")",
            "date": "\(self.getDateInDateFormate(date: Date()))",
            "description": "\(self.descriptionTextField.text ?? "")",
            "receiverId": ""
        ]
        Alamofire.upload(multipartFormData:
            {
                (multipartFormData) in
                multipartFormData.append((self.tempSelectedImage ?? UIImage(named: "building")!).jpegData(compressionQuality: 0.1)!, withName: "image", fileName: "file_\(Int.random(in: 0 ... 10000)).jpeg", mimeType: "image/jpeg")
                for (key, value) in params
                {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
        }, to:URL(string: "\(ngRokUrl)addnotice/\(loggedInUserId)") ?? "",headers:["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"])
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
