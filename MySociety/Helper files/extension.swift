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


extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}

extension UIViewController {
    
    func showToast(message : String, fontSize: CGFloat) {
        let toastLabel = UITextView(frame: CGRect(x: self.view.frame.size.width/16, y: self.view.frame.size.height-250, width: self.view.frame.size.width * 7/8, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = "   \(message)   "
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        toastLabel.font = UIFont(name: (toastLabel.font?.fontName)!, size: 16)
        //        toastLabel.layoutEdgeInsets.left = 8
        //        toastLabel.layoutEdgeInsets.right = 8
        toastLabel.center.x = self.view.frame.size.width/2
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
}

extension UIView{
    func giveCornerradius(){
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
}

extension UITextField{
    
    func giveBackShadow(){
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.0
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(1.0, 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 1.0
    }
    
}
extension CGSize{
    init(_ width:CGFloat,_ height:CGFloat) {
        self.init(width:width,height:height)
    }
}

extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x:x,y:y,width:width,height:height)
    }
    
}

extension UIView {
    func roundCornersWithLayerMask(cornerRadii: CGFloat, corners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    } }


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension Notification.Name {
    static let selectSocietyPopOverDismissNC = Notification.Name("selectSocietyPopOverDismissNC")
    static let selectUserMemberPopOverDismissNC = Notification.Name("selectUserMemberPopOverDismissNC")
    static let selectUserMemberForMaintenancePopOverDismissNC = Notification.Name("selectUserMemberForMaintenancePopOverDismissNC")
}

extension UICollectionView {
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x + self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }

    func scrollToPreviousItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x - self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }

    func moveToFrame(contentOffset : CGFloat) {
        self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
    }
}
