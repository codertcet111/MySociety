//
//  AddEventViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var topConstraints: NSLayoutConstraint!
    @IBOutlet weak var newEventTitleTextField: UITextField!
    @IBOutlet weak var newEventDescriptionTextField: UITextField!
    @IBOutlet weak var setEventDateLabel: UILabel!
    @IBOutlet weak var newEventDatePicker: UIDatePicker!
    @IBOutlet weak var newEventSelectImageBtn: UIButton!
    @IBOutlet weak var saveEventBtn: UIButton!
    @IBAction func SelectImageAction(_ sender: UIButton) {
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
        self.newEventSelectImageBtn.setTitle("\(selectedImage.accessibilityIdentifier ?? "Image Selected")", for: .normal)

        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    @IBAction func SaveEventAction(_ sender: UIButton) {
        self.createEvent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }
    
    func createEvent(){
                self.showSpinner(onView: self.view)
                let parameters = [
                    "title": "\(self.newEventTitleTextField.text ?? "")",
                    "date": "\(self.getDateInDateFormate(date: self.newEventDatePicker.date))",
                    "description": "\(self.newEventDescriptionTextField.text ?? "")",
                    "images": "https://images.app.goo.gl/yX1JXGNk7jkpZh6K9",
                    "adminId": "\(loggedInUserId)"
                    ] as [String : Any]
            let headerValues = ["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"]
                let request = getRequestUrlWithHeader(url: "addevent/\(loggedInUserId)", method: "POST", header: headerValues, bodyParams: parameters)
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
                                self.showAlert("Event Created Successfully!!")
                            }
                        default:
                            DispatchQueue.main.async {
                                self.showAlert("Some Error has occured, try again!")
                            }
                        }
                    }
                })
                
                dataTask.resume()
            }
        
        
        func showAlert(_ message: String) -> (){
            let alert = UIAlertController(title: message, message: nil , preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
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
    
    func getDateInDateFormate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
    
    func setView(){
        saveEventBtn.layer.cornerRadius = 10
        newEventSelectImageBtn.layer.cornerRadius = 10
        topConstraints.constant = 500
        topConstraints.constant = 45
        
        newEventTitleTextField.alpha = 0
        setEventDateLabel.alpha = 0
        newEventSelectImageBtn.alpha = 0
        saveEventBtn.alpha = 0
        newEventDescriptionTextField.alpha = 0
        newEventDatePicker.alpha = 0
        
        newEventTitleTextField.alpha = 1
        setEventDateLabel.alpha = 1
        newEventSelectImageBtn.alpha = 1
        saveEventBtn.alpha = 1
        newEventDescriptionTextField.alpha = 1
        newEventDatePicker.alpha = 1
        
        UIView.animate(withDuration: 1.5, animations: {
            self.view.layoutIfNeeded()
        })
    }


}
