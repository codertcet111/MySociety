//
//  postVideoViewController.swift
//  MySociety
//
//  Created by Admin on 15/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import MobileCoreServices
import AssetsLibrary

class postVideoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var videoURL: URL?
    @IBOutlet weak var newVideoTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var selectVideoTitleLabel: UILabel!
//    var selectedVideo
    @IBOutlet weak var selectVideoButton: UIButton!
    
    let imagePickerController = UIImagePickerController()
    @IBAction func selectVideoAction(_ sender: UIButton) {
//        imagePickerController.sourceType = .photoLibrary
//
//        if #available(iOS 11.0, *) {
////            imagePickerController.videoExportPreset = AVAssetExportPresetPassthrough
//            imagePickerController.videoExportPreset = "AVAssetExportPresetPassthrough"
//        }
//        imagePickerController.delegate = self
//        imagePickerController.mediaTypes = ["public.movie"]
//
//        present(imagePickerController, animated: true, completion: nil)
        
        if #available(iOS 11.0, *) {
            imagePickerController.videoExportPreset = "AVAssetExportPresetPassthrough"
        }
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func uploadBtnAction(_ sender: UIButton) {
        if checkAndValidateFieldBfrRegister(){
            showToast(message: "Will take few minutes", fontSize: 11.0)
            self.uploadMedia()
        }
    }
    
    func checkAndValidateFieldBfrRegister() -> Bool{
        if self.titleTextField.text == ""{
            showAlert("Please Type Title")
            return false
        }else if self.videoURL == nil{
            showAlert("Please select video!")
            return false
        }else{
            return true
        }
    }
    
    func showAlert(_ message: String) -> (){
        let alert = UIAlertController(title: message, message: nil , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var uploadBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//
//     let videoURL = info["UIImagePickerControllerReferenceURL"] as? NSURL
//     self.videoPath = videoURL as URL?
//     print(videoURL!)
//     imagePickerController.dismiss(animated: true, completion: nil)
//    }
    
//    func imagePickerController(  didFinishPickingMediaWithInfo info:NSDictionary!) {
//        let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as! NSURL?
//        let pathString = videoUrl?.relativePath
//        self.dismiss(animated: true, completion: nil)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        videoURL = info[UIImagePickerControllerMediaURL] as? URL
        guard let tempvideoURL = info[.mediaURL] as? URL else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        videoURL = tempvideoURL
        print("videoURL:\(String(describing: videoURL))")
        self.dismiss(animated: true, completion: nil)
    }
    
    func uploadMedia(){
        
        if videoURL == nil {
            return
        }

        showSpinner(onView: self.view)
        guard let url = URL(string: "\(ngRokUrl)uploadVideo/\(loggedInUserId)") else {
            return
        }
        var request = URLRequest(url: url)
        let boundary = "------------------------your_boundary"

        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var movieData: Data?
        do {
            movieData = try Data(contentsOf: videoURL!, options: Data.ReadingOptions.alwaysMapped)
        } catch _ {
            movieData = nil
            return
        }

        var body = Data()

        // change file name whatever you want
        let filename = "upload.mov"
        let mimetype = "video/mov"

        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(movieData!)
        request.httpBody = body

        let task = URLSession.shared.dataTask(with: request) { (data: Data?, reponse: URLResponse?, error: Error?) in
            DispatchQueue.main.sync {
                self.removeSpinner()
            }
            if let `error` = error {
                DispatchQueue.main.sync {
                    print(error)
                    self.showToast(message: "Some Error Accured!", fontSize: 11.0)
                }
                return
            }
            if let `data` = data {
                DispatchQueue.main.sync {
                    print(String(data: data, encoding: String.Encoding.utf8))
                    self.showToast(message: "Successfully Updated!", fontSize: 11.0)
                }
            }
        }

        task.resume()
    }

}

