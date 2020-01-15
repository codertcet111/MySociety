//
//  postVideoViewController.swift
//  MySociety
//
//  Created by Admin on 15/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class postVideoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var newVideoTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var selectVideoTitleLabel: UILabel!
    
    @IBOutlet weak var selectVideoButton: UIButton!
    
    @IBAction func selectVideoAction(_ sender: UIButton) {
        imagePickerController.sourceType = .photoLibrary

        imagePickerController.delegate = self

        imagePickerController.mediaTypes = ["public.image", "public.movie"]

        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func uploadBtnAction(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var uploadBtn: UIButton!
    
    
    let imagePickerController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {

     let videoURL = info["UIImagePickerControllerReferenceURL"] as? NSURL
     print(videoURL!)
     imagePickerController.dismiss(animated: true, completion: nil)
    }

}
