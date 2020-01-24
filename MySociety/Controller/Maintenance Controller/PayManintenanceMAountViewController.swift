//
//  PayManintenanceMAountViewController.swift
//  MySociety
//
//  Created by Admin on 15/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class PayManintenanceMAountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var tempSelectedImage: UIImage?
    @IBOutlet weak var selectWingBtn: UIButton!
    @IBAction func selectWingAction(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var sleectFlatBtn: UIButton!
    @IBAction func selectFlatAction(_ sender: UIButton) {
        
    }
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
        myImageUploadRequest()
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
        selectWingBtn.layer.cornerRadius = 10
        sleectFlatBtn.layer.cornerRadius = 10
        uploadImageBtn.layer.cornerRadius = 10
        saveBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
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
