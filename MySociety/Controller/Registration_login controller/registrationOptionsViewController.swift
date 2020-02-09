//
//  registrationOptionsViewController.swift
//  MySociety
//
//  Created by Admin on 17/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class registrationOptionsViewController: UIViewController {

    
//    @IBOutlet weak var mySocietyImageView: UIImageView!
    @IBOutlet weak var mySocietyLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
//    @IBOutlet weak var mySocietyImageViewTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var lgoINButton: UIButton!
    @IBAction func logInButtonAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "logINUserSegue", sender: self)
    }
    @IBOutlet weak var makeMySocietyBtn: UIButton!
    
    @IBAction func makeMySocietyAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "registerSocietySegue", sender: self)
    }
    
    @IBOutlet weak var becomeMmberBtn: UIButton!
    
    @IBAction func becomeMemeberAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "registerUserSegue", sender: self)
    }
    
//    @IBOutlet weak var contactUsBtn: UIButton!
    
//    @IBAction func contactUsAction(_ sender: UIButton) {
        
//    }
//    @IBOutlet weak var logInBtnWidthConstraits: NSLayoutConstraint!
//    @IBOutlet weak var registerSocietyWidthConstraints: NSLayoutConstraint!
//    @IBOutlet weak var signUpMemberBtnWidthConstraints: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.view.bringSubviewToFront(self.mySocietyImageView)
        self.view.bringSubviewToFront(self.lgoINButton)
        self.view.bringSubviewToFront(self.makeMySocietyBtn)
        self.view.bringSubviewToFront(self.becomeMmberBtn)
        
        let attrString = NSMutableAttributedString(string: "Register Society",
                                                   attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]);

//        attrString.append(NSMutableAttributedString(string: "(Secretary/ Chairman/ Treasurer)",
//                                                    attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]));
        self.makeMySocietyBtn.setTitle(attrString.string, for: .normal)
        self.lgoINButton.giveBorder()
        self.makeMySocietyBtn.giveBorder()
        self.becomeMmberBtn.giveBorder()
        self.animateView()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    func animateView(){
        lgoINButton.layer.cornerRadius = 10
        makeMySocietyBtn.layer.cornerRadius = 10
        becomeMmberBtn.layer.cornerRadius = 10
//        contactUsBtn.layer.cornerRadius = 10
        
//        self.mySocietyImageViewTopConstraints.constant = 700
//        self.mySocietyImageViewTopConstraints.constant = 40
//        lgoINButton.alpha = 0
//        makeMySocietyBtn.alpha = 0
//        becomeMmberBtn.alpha = 0
//        contactUsBtn.alpha = 0
//        self.logInBtnWidthConstraits.constant = 120
//        self.registerSocietyWidthConstraints.constant = 120
//        self.signUpMemberBtnWidthConstraints.constant = 120
//        UIView.animate(withDuration: 1.5, animations: {
//            self.view.layoutIfNeeded()
//            self.lgoINButton.alpha = 1
//            self.makeMySocietyBtn.alpha = 1
//            self.becomeMmberBtn.alpha = 1
//            self.contactUsBtn.alpha = 1
//            self.registerSocietyWidthConstraints.constant = 170
//            self.logInBtnWidthConstraits.constant = 170
//            self.signUpMemberBtnWidthConstraints.constant = 170
//        })
    }

}
