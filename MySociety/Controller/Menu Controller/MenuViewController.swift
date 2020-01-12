//
//  MenuViewController.swift
//  MySociety
//
//  Created by Admin on 10/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class MenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    var adminMenuOptions: [[String]] = [["Notice & Circular","Notice_Circulate"], ["Event","EventLogo"], ["Complaints", "complaint"], ["Maintenance", "maintenance"], ["Member Directory", "memberDirectory"], ["Opinion Poll", "poll"], ["Election", "ElectionIcon"], ["Group Chat","GroupChat"], ["FeedBack","feedback"], ["Manual Video","video-players"]]
    var userMenuOptions: [[String]] = []
    @IBOutlet weak var menuCollectionViewOutlet: UICollectionView!
    @IBOutlet weak var collectionTopConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var collectionHeightConstraints: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let layout = AnimatedCollectionViewLayout()
//        layout.animator = LinearCardAttributesAnimator()
//        menuCollectionViewOutlet.collectionViewLayout = layout
//        menuCollectionViewOutlet.reloadData()
        collectionTopConstraints.constant = 200
        collectionHeightConstraints.constant = 50.0
        collectionHeightConstraints.constant = 200
        UIView.animate(withDuration: 1.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adminMenuOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuViewCollectionViewCell", for: indexPath) as! menuViewCollectionViewCell
        let tempData = adminMenuOptions[indexPath.row]
        cell.cellImageView.image = UIImage(named: "\(tempData[1])")
        cell.cellMenuLabelOutlet.text = tempData[0]
//        cell.cellBackgroundView.layer.cornerRadius = 10.0
        return cell
    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSize(width: 263.0, height: 170.0)
//    }

}
