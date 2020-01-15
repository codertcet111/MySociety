//
//  newElectionViewController.swift
//  MySociety
//
//  Created by Admin on 15/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class newElectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var startTimeTitleLabel: UILabel!
    @IBOutlet weak var startTimeDatePicker: UIDatePicker!
    @IBOutlet weak var endDateTitleLabel: UILabel!
    @IBOutlet weak var endDateTimePicker: UIDatePicker!
    @IBOutlet weak var addOptionsTitleLabel: UILabel!
    
    @IBOutlet weak var addOptionTextField: UITextField!
    @IBOutlet weak var addOptionAddButton: UIButton!
    @IBAction func addOptionAddBtnAction(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var optionsTitleLabel: UILabel!
    @IBOutlet weak var optionsListTableView: UITableView!
    @IBAction func postBtnAction(_ sender: UIButton) {
        
    }
    @IBOutlet weak var postBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.optionsListTableView.estimatedRowHeight = 83
        self.optionsListTableView.rowHeight = UITableView.automaticDimension
        self.postBtn.layer.cornerRadius = 10
        self.optionsListTableView.layer.cornerRadius = 10
//        optionsListTableView.layer.borderColor = UIColor.lightGray.cgColor
//        optionsListTableView.layer.borderWidth = 1.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newElectionTableViewCell") as! newElectionTableViewCell
        cell.alpha = 0
        cell.selectionStyle = .none
        UIView.animate(withDuration: 1) {
            cell.alpha = 1.0
        }
        return cell
    }
    

}
