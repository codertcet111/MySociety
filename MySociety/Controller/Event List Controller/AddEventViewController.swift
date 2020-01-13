//
//  AddEventViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    
    @IBOutlet weak var topConstraints: NSLayoutConstraint!
    @IBOutlet weak var newEventTitleTextField: UITextField!
    @IBOutlet weak var newEventDescriptionTextField: UITextField!
    @IBOutlet weak var setEventDateLabel: UILabel!
    @IBOutlet weak var newEventDatePicker: UIDatePicker!
    @IBOutlet weak var newEventSelectImageBtn: UIButton!
    @IBOutlet weak var saveEventBtn: UIButton!
    @IBAction func SelectImageAction(_ sender: UIButton) {
        
    }
    @IBAction func SaveEventAction(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
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
