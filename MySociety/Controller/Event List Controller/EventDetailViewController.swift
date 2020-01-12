//
//  EventDetailViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventDetailPhotoGalleryCollectionView: UICollectionView!
    
    @IBOutlet weak var eventDetailDescriptionText: UILabel!
    
    @IBOutlet weak var eventDetailGalleryCOllectionViewHeightConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var eventDetailLAbelTopConstraints: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventDetailDescriptionText.text = "We will be having the birthday celebration for Anmol. He will be the morgan boy of the year. Lets celbrate his birthday for this year. We will be having the birthday celebration for Anmol. He will be the morgan boy of the year. Lets celbrate his birthday for this year."
        self.animateView()
        
    }
    
    func animateView(){
        eventTitleLabel.font = eventTitleLabel.font.withSize(50)
        eventTitleLabel.font = eventTitleLabel.font.withSize(17)
        eventDetailGalleryCOllectionViewHeightConstraints.constant = 0
        eventDetailGalleryCOllectionViewHeightConstraints.constant = 300
        eventDetailLAbelTopConstraints.constant = 600
        eventDetailLAbelTopConstraints.constant = 34
        UIView.animate(withDuration: 1.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 10
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventDetailImageGalleryCollectionViewCell", for: indexPath) as! EventDetailImageGalleryCollectionViewCell
    //        cell.cellBackgroundView.layer.cornerRadius = 10.0
            return cell
        }

}
