//
//  NewComplaintsViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class NewComplaintsViewController: UIViewController {

    @IBOutlet weak var registerNewComplaintTitleLabel: UILabel!
    
    @IBOutlet weak var newComplaintSubjectTextField: UITextField!
    
    @IBOutlet weak var newComplaintUploadImageBtn: UIButton!
    @IBAction func newComplaintUploadImageAction(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var newComplaintSaveBtn: UIButton!
    
    @IBAction func newComplaintSaveAction(_ sender: UIButton) {
        
    }
    
    
    @IBOutlet weak var newComplaintDescriptionTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }
    
    func setView(){
        self.newComplaintUploadImageBtn.layer.cornerRadius = 10
        self.newComplaintSaveBtn.layer.cornerRadius = 10
    }

}
