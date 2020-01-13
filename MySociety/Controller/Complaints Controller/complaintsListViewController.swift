//
//  complaintsListViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class complaintsListViewController: UIViewController {

    @IBOutlet weak var complaintsListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.complaintsListTableView.estimatedRowHeight = 164
        self.complaintsListTableView.rowHeight = UITableView.automaticDimension
    }
    

}
