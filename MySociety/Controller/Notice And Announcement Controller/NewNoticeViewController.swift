//
//  NewNoticeViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

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
        let parameters = [
            "userId": "\(loggedInUserId)",
            "title": "\(self.newNoticeSetTitleTextField.text ?? "")",
            "date": "\(self.getDateInDateFormate(date: Date()))",
            "description": "\(self.descriptionTextField.text ?? "")",
            "image": "https://images.app.goo.gl/yX1JXGNk7jkpZh6K9",
            "receiverId": ""
            ] as [String : Any]
        let headerValues = ["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"]
        let request = getRequestUrlWithHeader(url: "addnotice/\(loggedInUserId)", method: "POST", header: headerValues, bodyParams: parameters)
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
                        self.showAlert("Notice created Successfully!!")
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
    
    func getDateInDateFormate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }

}
