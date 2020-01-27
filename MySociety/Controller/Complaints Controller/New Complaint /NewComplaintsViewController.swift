//
//  NewComplaintsViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class NewComplaintsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var registerNewComplaintTitleLabel: UILabel!
    
    @IBOutlet weak var newComplaintSubjectTextField: UITextField!
    
    @IBOutlet weak var newComplaintUploadImageBtn: UIButton!
    @IBAction func newComplaintUploadImageAction(_ sender: UIButton) {
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
        self.newComplaintUploadImageBtn.setTitle("\(selectedImage.accessibilityIdentifier ?? "😄 Selected")", for: .normal)

        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var newComplaintSaveBtn: UIButton!
    
    @IBAction func newComplaintSaveAction(_ sender: UIButton) {
        self.createComplaint()
        self.newComplaintSubjectTextField.text = ""
        self.newComplaintDescriptionTextField.text = ""
    }
    
    
    @IBOutlet weak var newComplaintDescriptionTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }
    
    func createComplaint(){
                self.showSpinner(onView: self.view)
                let parameters = [
                    "userId": "\(loggedInUserId)",
                    "subject": "\(self.newComplaintSubjectTextField.text ?? "")",
                    "date": "\(self.getDateInDateFormate(date: Date()))",
                    "description": "\(self.newComplaintDescriptionTextField.text ?? "")",
                    "images": "https://images.app.goo.gl/yX1JXGNk7jkpZh6K9",
                    "status": "0"
                    ] as [String : Any]
            let headerValues = ["x-api-key": "1c552e6f2a95a883209e9b449d6f4973", "Content-Type": "application/json"]
                let request = getRequestUrlWithHeader(url: "addcomplaints/\(loggedInUserId)", method: "POST", header: headerValues, bodyParams: parameters)
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
                                self.showAlert("Complaint created Successfully!!")
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
    
    func setView(){
        self.newComplaintUploadImageBtn.layer.cornerRadius = 10
        self.newComplaintSaveBtn.layer.cornerRadius = 10
    }

}
