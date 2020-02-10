//
//  registrationOptionsViewController.swift
//  MySociety
//
//  Created by Admin on 17/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class registrationOptionsViewController: UIViewController, UIScrollViewDelegate {

    var slides:[Slide] = [];
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var contentPageControll: UIPageControl!
    
    @IBOutlet weak var secretoryChairmanSbTitleLabel: UILabel!
    
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
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//         return .default
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.view.bringSubviewToFront(self.mySocietyImageView)
        self.view.bringSubviewToFront(self.lgoINButton)
        self.view.bringSubviewToFront(self.makeMySocietyBtn)
        self.view.bringSubviewToFront(self.becomeMmberBtn)
        self.view.bringSubviewToFront(self.secretoryChairmanSbTitleLabel)
        
//        self.lgoINButton.giveBorder()
//        self.makeMySocietyBtn.giveBorder()
//        self.becomeMmberBtn.giveBorder()
        self.lgoINButton.layer.cornerRadius = 10.0
        self.makeMySocietyBtn.layer.cornerRadius = 10.0
        self.becomeMmberBtn.layer.cornerRadius = 10.0
        self.animateView()
        self.navigationController?.navigationBar.isHidden = false
        
        
        self.contentScrollView.delegate = self
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        contentPageControll.numberOfPages = slides.count
        contentPageControll.currentPage = 0
        view.bringSubviewToFront(self.contentScrollView)
        view.bringSubviewToFront(self.contentPageControll)
//        setButtonText()
        // Do any additional setup after loading the view.
    }
    
//    func setButtonText(){
//        let fulltext = "Register Society (Secretory/ Chairman/ Treasurer)"
//        let mainText = "Register Society "
//        let creditsText = "(Secretory/ Chairman/ Treasurer)"
//        let fontBig = UIFont.systemFont(ofSize: 12.0)
//        let fontSmall = UIFont.systemFont(ofSize: 9.0)
//        let attributedString = NSMutableAttributedString(string: fulltext, attributes: nil)
//
//        let bigRange = (attributedString.string as NSString).range(of: mainText)
//        let creditsRange = (attributedString.string as NSString).range(of: creditsText)
//        attributedString.setAttributes([NSAttributedString.Key.font: fontBig, NSAttributedString.Key.foregroundColor: UIColor.white], range: bigRange)
//        attributedString.setAttributes([NSAttributedString.Key.font: fontSmall, NSAttributedString.Key.foregroundColor: UIColor.white], range: creditsRange)
//
//        makeMySocietyBtn.setAttributedTitle(attributedString, for: .normal)
//    }
//
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sliderIndivisualWidth = CGFloat(view.frame.size.width - 48.0)
        let sliderIndivisualHeight = CGFloat(128.0)
            let pageIndex = round(contentScrollView.contentOffset.x/sliderIndivisualWidth)
        self.contentPageControll.currentPage = Int(pageIndex)
//
//            let maximumHorizontalOffset: CGFloat = contentScrollView.contentSize.width - contentScrollView.frame.width
//            let currentHorizontalOffset: CGFloat = contentScrollView.contentOffset.x
//
//            // vertical
//            let maximumVerticalOffset: CGFloat = contentScrollView.contentSize.height - contentScrollView.frame.height
//            let currentVerticalOffset: CGFloat = contentScrollView.contentOffset.y
//
//            let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
//            let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
//
            
            /*
             * below code changes the background color of view on paging the scrollview
             */
    //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
            
        
            /*
             * below code scales the imageview on paging the scrollview
             */
//            let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
//
//            if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
//
//                slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
//                slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
//
//            } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
//                slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
//                slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
//
//            } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
//                slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
//                slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
//
//            } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
//                slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
//                slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
//            }
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
    
    func createSlides() -> [Slide] {

        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.TitleHeaderTitle.text = "Connect Society"
        slide1.titleSubHeaderTitle.text = "Gets connected to all the members of your society"
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.TitleHeaderTitle.text = "Post Notice & Event"
        slide2.titleSubHeaderTitle.text = "Post your societies notice and functional events and chat in the group"
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.TitleHeaderTitle.text = "Election & Opinion"
        slide3.titleSubHeaderTitle.text = "Conduct election and opinion polls and cast the vote for it"
        
        return [slide1, slide2, slide3]
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        let sliderIndivisualWidth = CGFloat(view.frame.size.width - 48.0)
        let sliderIndivisualHeight = CGFloat(128.0)
        contentScrollView.frame = CGRect(x: 0, y: 0, width: sliderIndivisualWidth, height: sliderIndivisualHeight)
        contentScrollView.contentSize = CGSize(width: sliderIndivisualWidth * CGFloat(slides.count), height: sliderIndivisualHeight)
        contentScrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: sliderIndivisualWidth * CGFloat(i), y: 0, width: sliderIndivisualWidth, height: sliderIndivisualHeight)
            contentScrollView.addSubview(slides[i])
        }
    }

}
