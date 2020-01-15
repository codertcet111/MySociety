//
//  FeedbackViewController.swift
//  MySociety
//
//  Created by Admin on 15/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var feedbackTableView: UITableView!
    @IBOutlet weak var typeFeedbackView: UIView!
    @IBOutlet weak var selectEventButton: UIButton!
    
    @IBAction func selectEventBtnAction(_ sender: UIButton) {
        //Fetch and show all events Availabel
    }
    
    @IBOutlet weak var commentTypeTextField: UITextField!
    
    @IBOutlet weak var postBtn: UIButton!
    @IBAction func postBtnAction(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedbackTableView.estimatedRowHeight = 150
        self.feedbackTableView.rowHeight = UITableView.automaticDimension
        postBtn.layer.cornerRadius = 10
        selectEventButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedbackTableViewCell") as! feedbackTableViewCell
       cell.alpha = 0
       cell.feedbackCellBackgroundView.layer.cornerRadius = 10
       
       cell.selectionStyle = .none
       UIView.animate(withDuration: 1) {
           cell.alpha = 1.0
       }
       return cell
    }

}
