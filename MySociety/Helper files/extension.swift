//
//  extension.swift
//  MySociety
//
//  Created by Admin on 09/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func cornerRadius(radius: Float){
        layer.cornerRadius = CGFloat(radius)
        layer.masksToBounds = true
    }
    
    func bottomCornerRadius(radius: Float){
        
    }
    
    func dropShadow(scale: Bool = true) {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
        layer.cornerRadius = 10
        layer.masksToBounds = false
    }
    
    func dropSmallShadow(){
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
        layer.cornerRadius = 7
        layer.masksToBounds = false
    }
    
    func dropMicroSmallShadow(){
        layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 2
        layer.cornerRadius = 5
        layer.masksToBounds = false
    }
}

extension UISwitch {

    func set(width: CGFloat, height: CGFloat) {
        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51
        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth
        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}

extension String {
func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

extension UIImage{
    func imageByAddingBorder(width: CGFloat, color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContext(self.size)
        let imageRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        self.draw(in: imageRect)
        let context = UIGraphicsGetCurrentContext()
        let borderRect = imageRect.insetBy(dx: width / 2, dy: width / 2)
        context?.setStrokeColor(color.cgColor)
        context?.setLineWidth(width)
        context?.stroke(borderRect)
        let borderedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return borderedImage
    }
}

extension UITableView {
func reloadWithAnimation() {
    self.reloadData()
    let tableViewHeight = self.bounds.size.height
    let cells = self.visibleCells
    var delayCounter = 0
    for cell in cells {
        cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
    }
    for cell in cells {
        UIView.animate(withDuration: 1.6, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            cell.transform = CGAffineTransform.identity
        }, completion: nil)
        delayCounter += 1
    }
}
}

extension UITabBarController {
    func orderedTabBarItemViews() -> [UIView] {
        let interactionViews = tabBar.subviews.filter({$0.isUserInteractionEnabled})
    return interactionViews.sorted(by: {$0.frame.minX < $1.frame.minX})
    }
}
