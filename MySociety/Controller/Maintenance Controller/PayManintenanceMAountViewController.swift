//
//  PayManintenanceMAountViewController.swift
//  MySociety
//
//  Created by Admin on 15/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class PayManintenanceMAountViewController: UIViewController {

    
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
        
    }
    @IBOutlet weak var saveBtn: UIButton!
    @IBAction func saveBtnAction(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectWingBtn.layer.cornerRadius = 10
        sleectFlatBtn.layer.cornerRadius = 10
        uploadImageBtn.layer.cornerRadius = 10
        saveBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    

}
